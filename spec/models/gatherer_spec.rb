# frozen_string_literal: true

require 'rails_helper'

describe Gatherer, type: :model do
  let(:set_response) { double('set response') }
  let(:tms_response) { double('test magic set response') }
  let(:ats_response) { double('another test set response') }
  let(:test_card_response) { double('test card response') }
  let(:test_sets) do
    {
      'sets' => [
        {
          'code' => 'TMS',
          'name' => 'Test Magic Set',
          'type' => 'expansion',
          'border' => 'black',
          'booster' => [
            [
              'rare',
              'mythic rare'
            ],
            'uncommon',
            'uncommon',
            'uncommon',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'land',
            'marketing'
          ],
          'releaseDate' => '2017-11-03',
          'magicCardsInfoCode' => 'tms',
          'block' => 'Test Magic Block'
        },
        {
          'code' => 'ATS',
          'name' => 'Another Test Set',
          'type' => 'expansion',
          'border' => 'white',
          'booster' => [
            [
              'rare'
            ],
            'uncommon',
            'uncommon',
            'uncommon',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'common',
            'land',
            'marketing'
          ],
          'releaseDate' => '2017-12-12',
          'magicCardsInfoCode' => 'ats',
          'block' => 'Test Magic Block'
        }
      ]
    }
  end
  let(:test_cards) do
    {
      'cards' => [
        {
          'name' => 'some card',
          'manaCost' => '{1}{W}',
          'cmc' => 2,
          'colors' => ['White'],
          'colorIdentity' => ['W'],
          'type' => 'Creature — Angel',
          'types' => ['Creature'],
          'subtypes' => ['Angel'],
          'rarity' => 'Mythic Rare',
          'set' => 'RTR',
          'setName' => 'Test Magic Set',
          'text' => 'Flying',
          'artist' => 'Chris Walsh',
          'number' => '1',
          'power' => '5',
          'toughness' => '6',
          'flavor' => 'That good, good flavor.',
          'layout' => 'normal',
          'multiverseid' => 8675309,
          'imageUrl' => 'imageurl.com/assets/card.jpg',
          'rulings' => [
            {
              'date' => '2017-12-01',
              'text' => 'This is the best card ever.'
            }
          ],
          'foreignNames' => [
            {
              'name' => 'Some Foreign Name',
              'imageUrl' => 'imageurl.com/assets/card.jpg',
              'language' => 'Some Foreign Language',
              'multiverseid' => 5556703
            }
          ],
          'printings' => %w[RTR C15],
          'originalText' => 'Original text',
          'originalType' => 'Creature — Angel',
          'legalities' => [
            {
              'format' => 'Commander',
              'legality' => 'Legal'
            }
          ],
          'id' => '32e9a9ca8a42301c73857bb6f1cb1eb81bec59f6'
        }
      ]
    }
  end
  let(:no_cards) { { 'cards' => [] } }

  subject { Gatherer.new.gather }

  before(:each) do
    allow(set_response).to receive(:parsed_response) { test_sets }
    allow(HTTParty).to receive(:get).with(/.*sets/) { set_response }
    allow(tms_response).to receive(:parsed_response).and_return(
      test_cards,
      no_cards,
      no_cards,
      no_cards,
      no_cards
    )
    allow(HTTParty).to receive(:get).with(/.*cards\?set=TMS&page=[\d]+/) { tms_response }
    allow(ats_response).to receive(:parsed_response) { { 'cards' => [] } }
    allow(HTTParty).to receive(:get).with(/.*cards\?set=ATS&page=[\d]+/) { ats_response }
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
    end
  end
end
