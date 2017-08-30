require 'rails_helper'

describe Api::V1::DecksController, :type => :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:deck_1) { create(:deck, user_id: user.id) }
  let(:deck_2) { create(:deck, user_id: another_user.id)}

  before(:each) do
    sign_in(user)
  end

  describe 'GET #index' do
    it "retrieves the current user's decks" do
      get(:index, format: :json)
      expect(response).to be_success
      expect(assigns(:decks)).to match_array([deck_1])
    end
  end

  describe 'GET #show' do
    it "retrieves the correct deck by ID in the url" do
      get(:show, params: { id: deck_1.id }, format: :json)
      expect(response).to be_success
      expect(assigns(:deck)).to eq(deck_1)
    end
  end

  describe "POST #create" do
    it "creates a deck" do
      post(:create,
           params: { deck: { name: 'unique deck name', user_id: user.id }, format: :json },
           session: {})
      expect(Deck.count).to eq(1)
    end

    context "with rendered views" do
      render_views

      it "responds with the deck's attrs" do
        post(
          :create,
          params: {
            deck: {
              name: 'whatever',
              user_id: user.id,
              legal_format: 'modern',
              deck_type: 'beatdown',
              color: 'blue',
            },
            format: :json
          },
          session: {}
        )
        response_card = JSON.parse(response.body)

        expect(response).to be_success
        expect(response_card['name']).to eq('whatever')
        expect(response_card['user_id']).to eq(user.id)
        expect(response_card['legal_format']).to eq('modern')
        expect(response_card['id']).to eq(assigns(:deck).id)
        expect(response_card['color']).to eq('blue')
      end
    end
  end

  describe 'PUT #update' do
    it 'updates deck attributes with the ID in the URL' do
      expect(deck_1.name).to eq('Test Deck')
      post(:update,
           params: {id: deck_1.id, deck: { name: 'babadoos' }, format: :json },
           session: {})
      expect(Deck.find(deck_1.id).name).to eq('babadoos')
    end
  end
end
