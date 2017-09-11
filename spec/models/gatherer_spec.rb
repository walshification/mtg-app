# frozen_string_literal: true

require 'rails_helper'

describe Gatherer, type: :model do
  let(:client_responses) { YAML.load_file('spec/fixtures/gatherer_responses.yml') }
  let(:fake_client) { double('API client') }

  subject { Gatherer.new(client: fake_client).gather }

  before(:each) do
    allow(fake_client).to receive(:get_sets) { client_responses['two_sets'] }
    allow(fake_client).to receive(:get_cards).with('TMS') { client_responses['tms_cards'] }
    allow(fake_client).to receive(:get_cards).with('ATS') { [] }
    allow(fake_client).to receive(:get_cards).with('YAS') { client_responses['yas_cards'] }
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
        expect(MagicSet.count).to eq(2)
        subject
        expect(MagicSet.count).to eq(2)
      end

      it 'only gathers specified sets if codes are provided' do
        Gatherer.new(client: fake_client, set_codes: ['TMS']).gather
        gathered_codes = MagicSet.all.pluck(:code)
        expect(gathered_codes).to include('TMS')
        expect(gathered_codes).to_not include('ATS')
      end

      it 'saves a new set if it has not already' do
        subject
        expect(MagicSet.count).to eq(2)
        allow(fake_client).to receive(:get_sets) { client_responses['three_sets'] }
        Gatherer.new(client: fake_client).gather
        expect(MagicSet.count).to eq(3)
      end
    end

    context 'gathering cards' do
      it 'saves creatures' do
        subject
        retrieved_card = Card.find_by(name: 'some card')
        expect(retrieved_card.name).to eq('some card')
        expect(retrieved_card.multiverse_id).to eq(8675309)
        expect(retrieved_card.magic_set.name).to eq('Test Magic Set')
        expect(retrieved_card.image_url).to eq('imageurl.com/assets/card.jpg')
        expect(retrieved_card.types).to eq(['Creature'])
        expect(retrieved_card.subtypes).to eq(['Angel'])
        expect(retrieved_card.layout).to eq('normal')
        expect(retrieved_card.mana_cost).to eq('{1}{W}')
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
        expect(retrieved_card.border).to eq('black')
        expect(retrieved_card.timeshifted).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.hand).to eq(nil)
        expect(retrieved_card.life).to eq(nil)
        expect(retrieved_card.reserved).to eq(false)
        expect(retrieved_card.release_date).to eq(nil)
        expect(retrieved_card.starter).to eq(false)
        expect(retrieved_card.original_text).to eq('Original text')
        expect(retrieved_card.original_type).to eq('Creature — Angel')
        expect(retrieved_card.source).to eq(nil)
      end

      it 'saves sorceries' do
        subject
        retrieved_card = Card.find_by(name: 'Day of Judgment')
        expect(retrieved_card.name).to eq('Day of Judgment')
        expect(retrieved_card.multiverse_id).to eq(186309)
        expect(retrieved_card.magic_set.name).to eq('Test Magic Set')
        expect(retrieved_card.image_url).to eq(
          'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=186309&type=card'
        )
        expect(retrieved_card.types).to eq(['Sorcery'])
        expect(retrieved_card.subtypes).to eq(nil)
        expect(retrieved_card.layout).to eq('normal')
        expect(retrieved_card.cmc).to eq(4)
        expect(retrieved_card.mana_cost).to eq('{2}{W}{W}')
        expect(retrieved_card.rarity).to eq('Rare')
        expect(retrieved_card.text).to eq('Destroy all creatures.')
        # rubocop:disable StringLiterals
        expect(retrieved_card.flavor).to eq(
          "\"I have seen planes leveled and all life rendered to dust. "\
          "It brought no pleasure, even to a heart as dark as mine.\"\n"\
          "—Sorin Markov\n"
        )
        # rubocop:enable StringLiterals
        expect(retrieved_card.artist).to eq('Vincent Proce')
        expect(retrieved_card.number).to eq('9')
        expect(retrieved_card.power).to eq(nil)
        expect(retrieved_card.toughness).to eq(nil)
        expect(retrieved_card.loyalty).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.border).to eq('black')
        expect(retrieved_card.timeshifted).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.hand).to eq(nil)
        expect(retrieved_card.life).to eq(nil)
        expect(retrieved_card.reserved).to eq(false)
        expect(retrieved_card.release_date).to eq(nil)
        expect(retrieved_card.starter).to eq(false)
        expect(retrieved_card.original_text).to eq('Destroy all creatures.')
        expect(retrieved_card.original_type).to eq('Sorcery')
        expect(retrieved_card.source).to eq(nil)
      end

      it 'saves enchantments' do
        subject
        retrieved_card = Card.find_by(name: 'Deathgrip')
        expect(retrieved_card.multiverse_id).to eq(202478)
        expect(retrieved_card.name).to eq('Deathgrip')
        expect(retrieved_card.image_url).to eq(
          'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=202478&type=card'
        )
        expect(retrieved_card.layout).to eq('normal')
        expect(retrieved_card.cmc).to eq(2)
        expect(retrieved_card.mana_cost).to eq('{B}{B}')
        expect(retrieved_card.rarity).to eq('Rare')
        expect(retrieved_card.text).to eq('{B}{B}: Counter target green spell.')
        expect(retrieved_card.flavor).to eq(nil)
        expect(retrieved_card.artist).to eq('Anson Maddocks')
        expect(retrieved_card.number).to eq('75')
        expect(retrieved_card.power).to eq(nil)
        expect(retrieved_card.toughness).to eq(nil)
        expect(retrieved_card.loyalty).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.border).to eq('black')
        expect(retrieved_card.timeshifted).to eq(nil)
        expect(retrieved_card.hand).to eq(nil)
        expect(retrieved_card.life).to eq(nil)
        expect(retrieved_card.reserved).to eq(false)
        expect(retrieved_card.release_date).to eq(nil)
        expect(retrieved_card.starter).to eq(false)
        expect(retrieved_card.original_text).to eq(nil)
        expect(retrieved_card.original_type).to eq(nil)
        expect(retrieved_card.source).to eq(nil)
        expect(retrieved_card.types).to eq(['Enchantment'])
        expect(retrieved_card.subtypes).to eq(nil)
        expect(retrieved_card.magic_set.name).to eq('Test Magic Set')
      end

      it 'saves planeswalkers' do
        subject
        retrieved_card = Card.find_by(name: 'Jace, the Mind Sculptor')
        expect(retrieved_card.name).to eq('Jace, the Mind Sculptor')
        expect(retrieved_card.multiverse_id).to eq(382979)
        expect(retrieved_card.magic_set.name).to eq('Test Magic Set')
        expect(retrieved_card.image_url).to eq(
          'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=382979&type=card'
        )
        expect(retrieved_card.types).to eq(['Planeswalker'])
        expect(retrieved_card.subtypes).to eq(['Jace'])
        expect(retrieved_card.layout).to eq('normal')
        expect(retrieved_card.cmc).to eq(4)
        expect(retrieved_card.mana_cost).to eq('{2}{U}{U}')
        expect(retrieved_card.rarity).to eq('Mythic Rare')
        # rubocop:disable StringLiterals
        expect(retrieved_card.text).to eq(
          "+2: Look at the top card of target player's library. "\
          "You may put that card on the bottom of that player's library.\n"\
          "0: Draw three cards, then put two cards from your hand "\
          "on top of your library in any order.\n"\
          "−1: Return target creature to its owner's hand.\n"\
          "−12: Exile all cards from target player's library, then that player "\
          "shuffles his or her hand into his or her library.\n"
        )
        # rubocop:enable StringLiterals
        expect(retrieved_card.flavor).to eq(nil)
        expect(retrieved_card.artist).to eq('Jason Chan')
        expect(retrieved_card.number).to eq('74')
        expect(retrieved_card.power).to eq(nil)
        expect(retrieved_card.toughness).to eq(nil)
        expect(retrieved_card.loyalty).to eq(3)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.border).to eq('black')
        expect(retrieved_card.timeshifted).to eq(nil)
        expect(retrieved_card.watermark).to eq(nil)
        expect(retrieved_card.hand).to eq(nil)
        expect(retrieved_card.life).to eq(nil)
        expect(retrieved_card.reserved).to eq(false)
        expect(retrieved_card.release_date).to eq(nil)
        expect(retrieved_card.starter).to eq(false)
        # rubocop:disable StringLiterals
        expect(retrieved_card.original_text).to eq(
          "+2: Look at the top card of target player's library. "\
          "You may put that card on the bottom of that player's library.\n"\
          "0: Draw three cards, then put two cards from your hand "\
          "on top of your library in any order.\n"\
          "−1: Return target creature to its owner's hand.\n"\
          "−12: Exile all cards from target player's library, then that player "\
          "shuffles his or her hand into his or her library.\n"
        )
        # rubocop:enable StringLiterals
        expect(retrieved_card.original_type).to eq('Planeswalker — Jace')
        expect(retrieved_card.source).to eq(nil)
      end

      it 'only saves cards once' do
        subject
        expect(Card.count).to eq(5)
        subject
        expect(Card.count).to eq(5)
      end
    end
  end
end
