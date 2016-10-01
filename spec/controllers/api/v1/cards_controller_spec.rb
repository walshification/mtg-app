require 'rails_helper'

describe Api::V1::CardsController, :type => :controller do
  let(:user) { create(:user) }
  let!(:card_1) { create(:card, name: "Fake Card", multiverse_id: 1) }
  let!(:card_2) { create(:card, name: "Second Fake", multiverse_id: 2) }
  let!(:card_3) { create(:card, name: "Third One", multiverse_id: 3) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in(user)
  end

  describe 'GET #index' do
    context 'without params' do
      it "returns an empty array of cards" do
        get(:index, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end

    context 'with params[:name]' do
      it "returns an array of cards with names matching search query" do
        card_1 = Card.find_by(multiverse_id: 1)
        card_2 = Card.find_by(multiverse_id: 2)
        get(:index, name: "Fake", format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([card_1, card_2])
      end

      it "returns an empty array when no card names match the query" do
        get(:index, name: "Not Present", format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end

    context 'with params[:multiverse]' do
      it "returns a single card with matching multiverse ID" do
        card_1 = Card.find_by(multiverse_id: 1)
        get(:index, multiverse_id: 1, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([card_1])
      end

      it "returns an empty array when no card matches the multiverse ID" do
        get(:index, multiverse_id: 9000, format: :json)

        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end
  end

  describe 'GET #show' do
    it "assigns the proper card based on the request id" do
      get(:show, id: card_1.id, format: :json)

      expect(response).to be_success
      expect(assigns(:card)).to eq(card_1)
    end
  end
end
