# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::CardsController, type: :controller do
  let(:user) { create(:user) }
  let(:magic_set) { create(:magic_set, name: 'some set') }
  let!(:fake_card) do
    create(:card, name: 'Fake Card', multiverse_id: 1, magic_set_id: magic_set.id)
  end
  let!(:second_fake) do
    create(:card, name: 'Second Fake', multiverse_id: 2, magic_set_id: magic_set.id)
  end
  let!(:third_fake) do
    create(:card, name: 'Third One', multiverse_id: 3, magic_set_id: magic_set.id)
  end

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
        fake_card = Card.find_by(multiverse_id: 1)
        second_fake = Card.find_by(multiverse_id: 2)
        get(:index, params: { name: 'Fake' }, format: :json)
        expect(response).to be_success
        expect(assigns(:cards)).to match_array([fake_card, second_fake])
      end

      it 'returns an empty array when no card names match the query' do
        get(:index, params: { name: 'Not Present' }, format: :json)
        expect(response).to be_success
        expect(assigns(:cards)).to match_array([])
      end
    end

    context 'with params[:multiverse]' do
      it 'returns a single card with matching multiverse ID' do
        fake_card = Card.find_by(multiverse_id: 1)
        get(:index, params: { multiverse_id: 1 }, format: :json)
        expect(response).to be_success
        expect(assigns(:cards)).to match_array([fake_card])
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
      get(:show, params: { id: fake_card.id }, format: :json)
      expect(response).to be_success
      expect(assigns(:card)).to eq(fake_card)
    end
  end
end
