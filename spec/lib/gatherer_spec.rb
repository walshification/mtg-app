# frozen_string_literal: true

require 'rails_helper'
require 'gatherer'

describe Gatherer, type: :lib do
  let(:test_set_response) { double('test set response') }
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

  subject { Gatherer.new.gather }

  before(:each) do
    allow(test_set_response).to receive(:parsed_response) { test_sets }
    allow(HTTParty).to receive(:get).with("#{ENV['MAGIC_API_ROOT_URL']}sets") do
      test_set_response
    end
    allow(test_card_response).to receive(:parsed_response) { test_cards }
    allow(HTTParty).to receive(:get).with("#{ENV['MAGIC_API_ROOT_URL']}cards?set=TMS") do
      test_card_response
    end
  end

  describe '.gather' do
    context 'gathering sets' do
      it 'saves names' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.name).to eq('Test Magic Set')
      end

      it 'saves codes' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.code).to eq('TMS')
      end

      it 'saves magiccards_info codes' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.magiccards_info_code).to eq('tms')
      end

      it 'saves border colors' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.border).to eq('black')
      end

      it 'saves types' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.set_type).to eq('expansion')
      end

      it 'saves blocks' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.block).to eq('Test Magic Block')
      end

      it 'saves release dates' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.release_date).to eq('2017-11-03')
      end

      it 'saves whether or not the set is online only' do
        subject
        retrieved_set = MagicSet.all.first
        expect(retrieved_set.online_only).to eq(false)
      end
    end

    context 'gathering cards' do
      it 'requires names and multiverse_ids' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.name).to eq('some card')
        expect(retrieved_card.multiverse_id).to eq(8675309)
      end

      it 'saves the card under the right set' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.magic_set.name).to eq('Test Magic Set')
      end

      it 'saves the image URL' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.image_url).to eq('imageurl.com/assets/card.jpg')
      end

      it 'saves the types' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.types).to eq(['Creature'])
      end

      it 'saves subtypes' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.subtypes).to eq(['Angel'])
      end

      it 'saves layouts' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.layout).to eq('normal')
      end

      it 'saves cmc' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.cmc).to eq(2)
      end

      it 'saves rarities' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.rarity).to eq('Mythic Rare')
      end

      it 'saves text' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.text).to eq('Flying')
      end

      it 'saves flavor' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.flavor).to eq('That good, good flavor.')
      end

      it 'saves artist' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.artist).to eq('Chris Walsh')
      end

      it 'saves set number' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.number).to eq('1')
      end

      it 'saves power' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.power).to eq('5')
      end

      it 'saves toughness' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.toughness).to eq('6')
      end

      it 'saves loyalty if it exists' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.loyalty).to eq(nil)
      end

      it 'saves watermark' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.watermark).to eq(nil)
      end

      it 'saves border' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.border).to eq(nil)
      end

      it 'saves whether or not it is timeshifted' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.timeshifted).to eq(nil)
      end

      it 'saves watermark' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.watermark).to eq(nil)
      end

      it 'saves hand for Vanguard cards' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.hand).to eq(nil)
      end

      it 'saves lifefor Vanguard cards' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.life).to eq(nil)
      end

      it 'saves if it is on the reserved list' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.reserved).to eq(false)
      end

      it 'saves release date for promo cards' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.release_date).to eq(nil)
      end

      it 'saves if it was only released in core box sets' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.starter).to eq(false)
      end

      it 'saves original text' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.original_text).to eq(nil)
      end

      it 'saves original type' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.original_type).to eq(nil)
      end

      it 'saves source of card for promos and theme decks' do
        subject
        retrieved_card = Card.all.first
        expect(retrieved_card.source).to eq(nil)
      end
    end
  end
end
