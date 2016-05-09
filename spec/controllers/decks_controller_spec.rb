require 'rails_helper'

describe DecksController, :type => :controller do

  let(:user) { create(:user) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in(user)
  end

  describe 'GET #index' do

    it "populates an array with the current user's decks" do
      deck = create(:deck)
      get(:index)
      expect(assigns(:decks)).to match_array([deck])
    end

    it "renders the index template" do
      get(:index)
      expect(response).to render_template("index")
    end
  end

  describe 'GET #show' do

    it "assigns the requested deck to @deck" do
      deck = create(:deck)
      get(:show, id: deck.id)
      expect(assigns(:deck)).to eq(deck)
    end

    it "renders the index template" do
      deck = create(:deck)
      get(:show, id: deck.id)
      expect(response).to render_template("show")
    end
  end
end
