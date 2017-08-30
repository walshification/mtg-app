require 'rails_helper'

describe Api::V1::CardsController, :type => :controller do
  let(:user) { create(:user) }
  let(:magic_set) { create(:magic_set, name: 'some set') }
  let!(:card_1) { create(:card, name: 'Fake Card', multiverse_id: 1, magic_set_id: magic_set.id) }
  let!(:card_2) { create(:card, name: 'Second Fake', multiverse_id: 2, magic_set_id: magic_set.id) }
  let!(:card_3) { create(:card, name: 'Third One', multiverse_id: 3, magic_set_id: magic_set.id) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in(user)
  end

  describe 'GET #index' do
    context 'without params' do
      it 'returns an empty array of cards' do
        get(:index, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end

    context 'with params[:name]' do
      it 'returns an array of cards with names matching search query' do
        card_1 = Card.find_by(multiverse_id: 1)
        card_2 = Card.find_by(multiverse_id: 2)
        get(:index, params: { name: 'Fake' }, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([card_1, card_2])
      end

      it 'returns an empty array when no card names match the query' do
        get(:index, params: { name: 'Not Present' }, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end

    context 'with params[:multiverse]' do
      it 'returns a single card with matching multiverse ID' do
        card_1 = Card.find_by(multiverse_id: 1)
        get(:index, params: { multiverse_id: 1 }, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([card_1])
      end

      it 'returns an empty array when no card matches the multiverse ID' do
        get(:index, params: { multiverse_id: 9000 }, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the proper card based on the request id' do
      get(:show, params: { id: card_1.id }, format: :json)

      expect(response).to be_success
      expect(assigns(:card)).to eq(card_1)
    end
  end
end
