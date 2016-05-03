require 'rails_helper'

describe CardScraper, type: :model do

  let(:fake_httparty) { double("HTTParty") }
  let(:fake_response) { double("http response") }
  let(:fake_card_class) { double("Card") }

  before(:each) do
    fake_card = { multiverseid: 1 }
    nested_cards = { "cards": [fake_card] }
    allow(fake_httparty).to receive(:get) { fake_response }
    allow(fake_response).to receive(:parsed_response) { nested_cards }
    allow(fake_card_class).to receive(:find_by) { nil }
    allow(fake_card_class).to receive(:create)
  end

  it "calls API to gather cards" do
    expect(fake_httparty).to receive(:get).with(
      "https://api.magicthegathering.io/v1/cards?set=fake_set")

    CardScraper.create_cards(
      sets: ["fake_set"],
      client: fake_httparty,
      card_class: fake_card_class
    )
  end

  it "creates a new card if no card is found" do
    expect(fake_card_class).to receive(:create)

    CardScraper.create_cards(
      sets: ["fake_set"],
      client: fake_httparty,
      card_class: fake_card_class
    )
  end

  it "doesn't create a new card if a card is found" do
    allow(fake_card_class).to receive(:find_by) { 'card' }
    expect(fake_card_class).to_not receive(:create)

    CardScraper.create_cards(
      sets: ["fake_set"],
      client: fake_httparty,
      card_class: fake_card_class
    )
  end
end
