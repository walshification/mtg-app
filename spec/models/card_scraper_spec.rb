require 'rails_helper'

describe CardScraper, type: :model do

  let(:fake_httparty) { double("HTTParty") }
  let(:fake_response) { double("http response") }
  let(:api_set) { { code: "FOO" } }
  let(:fake_set) { double("MagicSet") }

  subject { described_class.new(fake_httparty) }

  before(:each) do
    nested_sets = { sets: [api_set] }
    allow(fake_httparty).to receive(:get) { fake_response }
    allow(fake_response).to receive(:parsed_response) { nested_sets }
    allow(fake_set).to receive(:code) { "FOO" }
    allow(subject).to receive(:set) { fake_set }
  end

  it "calls API to gather sets" do
    allow(subject).to receive(:doublecheck_these) { [fake_set] }
    expect(fake_httparty).to receive(:get).with(
      "https://api.magicthegathering.io/v1/sets")
    subject.gather
  end

  # it "creates a new set if no set is found" do
  #   allow(MagicSet).to receive(:create) { fake_set }
  #   expect(MagicSet).to receive(:create)
  #
  #   subject.gather
  # end

  # it "doesn't create a new card if a card is found" do
  #   allow(fake_card_class).to receive(:find_by) { 'card' }
  #   expect(fake_card_class).to_not receive(:create)
  #
  #   subject
  # end
end
