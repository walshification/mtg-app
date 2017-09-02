require 'rails_helper'

describe CardScraper, type: :model do
  let(:fake_httparty) { double('HTTParty') }
  let(:fake_response) { double('http response') }
  let(:api_set) { { 'code' => 'FOO', 'type' => 'foo_type' } }
  let(:fake_set) { double('MagicSet') }
  let(:api_card) { { 'multiverseid' => 'foo234', 'imageUrl' => 'foo_url' } }
  let(:fake_card) { double('Card') }

  subject { described_class.new(fake_httparty) }

  context 'finding sets' do
    before(:each) do
      nested_sets = { sets: [api_set] }
      allow(fake_httparty).to receive(:get) { fake_response }
      allow(fake_response).to receive(:parsed_response) { nested_sets }
      allow(fake_set).to receive(:code) { 'FOO' }
      allow(subject).to receive(:set) { fake_set }
    end

    it 'calls API to gather sets' do
      allow(subject).to receive(:doublecheck_these) { [fake_set] }
      expect(fake_httparty).to receive(:get).with(
        "#{ENV['MAGIC_API_ROOT_URL']}sets"
      )
      subject.gather
    end

    it 'creates a new set if no set is found in the database' do
      allow(subject).to receive(:cards_in)
      allow(MagicSet).to receive(:create) { fake_set }
      expect(MagicSet).to receive(:create)
      subject.gather
    end

    it 'does not create a new set if a set is found in the database' do
      allow(subject).to receive(:cards_in)
      allow(MagicSet).to receive(:find_by) { fake_set }
      expect(MagicSet).to_not receive(:create)
      subject.gather
    end

    it 'converts camelcase attrs to snakecase' do
      allow(subject).to receive(:cards_in)
      allow(MagicSet).to receive(:create) { fake_set }
      expect(MagicSet).to receive(:create).with(
        { 'code'=>'FOO', 'set_type'=>'foo_type' }
      )
      subject.gather
    end
  end

  context 'finding cards' do
    before(:each) do
      nested_cards = { cards: [api_card] }
      allow(fake_httparty).to receive(:get) { fake_response }
      allow(fake_response).to receive(:parsed_response) { nested_cards }
      allow(fake_set).to receive(:code) { 'FOO' }
      allow(subject).to receive(:sets) { [fake_set] }
      allow(subject).to receive(:set) { fake_set }
    end

    it 'calls API to gather cards' do
      allow(subject).to receive(:doublecheck_these) { [fake_card] }
      expect(fake_httparty).to receive(:get).with(
        "#{ENV["MAGIC_API_ROOT_URL"]}cards?set=FOO"
      )
      subject.gather
    end

    it 'creates a new card if no card is found in the database' do
      allow(Card).to receive(:create) { fake_card }
      expect(Card).to receive(:create)
      subject.gather
    end

    it 'does not create a new card if a card is found in the database' do
      allow(Card).to receive(:find_by) { fake_card }
      expect(Card).to_not receive(:create)
      subject.gather
    end

    it 'converts camelcase attrs to snakecase' do
      allow(Card).to receive(:create) { fake_set }
      expect(Card).to receive(:create).with(
        { 'multiverse_id'=>'foo234', 'image_url'=>'foo_url' })
      subject.gather
    end
  end
end
