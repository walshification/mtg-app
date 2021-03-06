# frozen_string_literal: true

require 'rails_helper'

describe Gatherer, type: :model do
  let(:test_response) { double('test card response') }
  let(:api_response) { YAML.load_file('spec/fixtures/magic_api_responses.yml') }
  let(:no_cards) { { 'cards' => [] } }

  subject { Gatherer.new.gather }

  before(:each) do
    allow(test_response).to receive(:parsed_response).and_return(
      api_response, # once for sets
      api_response, # next five for cards
      no_cards,
      no_cards,
      no_cards,
      no_cards
    )
    allow(HTTParty).to receive(:get) { test_response }
  end

  describe '#gather' do
    context 'gathering sets' do
      it 'saves retrieved sets' do
        subject
        retrieved_set = MagicSet.find_by(name: 'Test Magic Set')
        expect(retrieved_set.name).to eq('Test Magic Set')
        expect(retrieved_set.code).to eq('TMS')
        expect(retrieved_set.magiccards_info_code).to eq('tms')
        expect(retrieved_set.border).to eq('black')
        expect(retrieved_set.set_type).to eq('expansion')
        expect(retrieved_set.block).to eq('Test Magic Block')
        expect(retrieved_set.release_date).to eq('2017-11-03')
        expect(retrieved_set.online_only).to eq(false)
      end

      it 'only saves sets once' do
        subject
        subject
        expect(MagicSet.count).to eq(2)
      end
    end

    context 'gathering cards' do
      it 'saves retrieved cards' do
        subject
        retrieved_card = Card.find_by(name: 'some card')
        expect(retrieved_card.name).to eq('some card')
        expect(retrieved_card.multiverse_id).to eq(8675309)
        expect(retrieved_card.magic_set.name).to eq('Test Magic Set')
        expect(retrieved_card.image_url).to eq('imageurl.com/assets/card.jpg')
        expect(retrieved_card.types).to eq(['Creature'])
        expect(retrieved_card.subtypes).to eq(['Angel'])
        expect(retrieved_card.layout).to eq('normal')
        expect(retrieved_card.cmc).to eq(2)
        expect(retrieved_card.rarity).to eq('Mythic Rare')
        expect(retrieved_card.text).to eq('Flying')
        expect(retrieved_card.flavor).to eq('That good, good flavor.')
        expect(retrieved_card.artist).to eq('Chris Walsh')
        expect(retrieved_card.number).to eq('1')
        expect(retrieved_card.power).to eq('5')
        expect(retrieved_card.toughness).to eq('6')
        expect(retrieved_card.loyalty).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.border).to eq(nil)
        expect(retrieved_card.timeshifted).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.hand).to eq(nil)
        expect(retrieved_card.life).to eq(nil)
        expect(retrieved_card.reserved).to eq(false)
        expect(retrieved_card.release_date).to eq(nil)
        expect(retrieved_card.starter).to eq(false)
        expect(retrieved_card.original_text).to eq(nil)
        expect(retrieved_card.original_type).to eq(nil)
        expect(retrieved_card.source).to eq(nil)
      end

      it 'only saves cards once' do
        subject
        subject
        expect(Card.count).to eq(1)
      end
    end
  end
end
