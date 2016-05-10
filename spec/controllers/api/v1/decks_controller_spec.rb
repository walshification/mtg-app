require 'rails_helper'

describe Api::V1::DecksController, :type => :controller do

  let(:user) { create(:user) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in(user)
  end

  # describe "#create" do
  #   it "creates a deck" do
  #     expect {
  #       post :create, { deck: { name: "asdf" }, format: :json }, {}
  #     }.to change { Deck.count }.by(1)
  #   end
  #
  #   context "with rendered views" do
  #     render_views
  #     it "responds with the deck's attrs" do
  #       post :create, {
  #         deck: {
  #           name: 'whatever',
  #           user_id: user.id,
  #           legal_format: 'modern',
  #           deck_type: 'beatdown',
  #           color: 'blue',
  #         }, format: :json
  #       }, {}
  #
  #       expect(JSON.parse(response.body)).to eq(
  #         'name' => 'whatever',
  #         'user_id' => user.id,
  #         'legal_format' => 'modern',
  #         'deck_type' => 'beatdown',
  #         'id' => assigns(:deck).id,
  #         'color' => 'blue',
  #         'cards' => [],
  #       )
  #     end
  #   end
  # end
end
