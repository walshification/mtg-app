require 'rails_helper'

describe CardScraper, type: :model do
  let(:fake_httparty) { double("HTTParty") }
  let(:fake_response) { double("http response") }
  # let(:fake_set_class) { double("MagicSet") }

  subject { described_class.new(fake_httparty) }

  before(:each) do
    # fake_card = { multiverseid: 1 }
    fake_set = double("MagicSet")
    nested_sets = { sets: [fake_set] }
    # nested_cards = { "cards": [ fake_card ] }
    allow(fake_httparty).to receive(:get) { fake_response }
    allow(fake_response).to receive(:parsed_response) { nested_sets }
    # allow(fake_set_class).to receive(:find_by)
    # allow(fake_set_class).to receive(:create)
    # allow(fake_set).to receive(:dig)
    # allow(fake_set).to receive(:[])
    # allow(fake_set).to receive(:keys) { [] }
    # allow(subject).to receive(:doublecheck_these)
    # allow(subject).to receive(:cards_in)
  end


  it "calls API to gather sets" do
    allow(subject).to receive(:doublecheck_these)

    subject.gather
    expect(fake_httparty).to have_received(:get)
  end

  # it "creates a new card if no card is found" do
  #   expect(fake_set_class).to receive(:create)
  #
  #   subject
  # end
  #
  # it "doesn't create a new card if a card is found" do
  #   allow(fake_card_class).to receive(:find_by) { 'card' }
  #   expect(fake_card_class).to_not receive(:create)
  #
  #   subject
  # end
end
