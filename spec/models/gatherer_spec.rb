# frozen_string_literal: true

require 'rails_helper'

describe Gatherer, type: :model do
  let(:fake_client) { double('fake client') }
  let(:set_response) { double('magic sets') }
  let(:new_set_response) { double('new set response') }
  let(:tms_response) { double('test magic set cards') }
  let(:ats_response) { double('another test set cards') }
  let(:yas_response) { double('yet another set cards') }
  let(:api_responses) { YAML.load_file('spec/fixtures/magic_api_responses.yml') }
  let(:no_cards) { { 'cards' => [] } }

  subject { Gatherer.new(client: fake_client).gather }

  before(:each) do
    allow(set_response).to receive(:parsed_response) { api_responses['two_sets'] }
    allow(new_set_response).to receive(:parsed_response) { api_responses['three_sets'] }
    allow(tms_response).to receive(:parsed_response).and_return(
      api_responses['tms_cards'],
      no_cards,
      no_cards,
      no_cards,
      no_cards
    )
    allow(ats_response).to receive(:parsed_response).and_return(
      no_cards,
      no_cards,
      no_cards,
      no_cards,
      no_cards
    )
    allow(yas_response).to receive(:parsed_response).and_return(
      api_responses['yas_cards'],
      no_cards,
      no_cards,
      no_cards,
      no_cards
    )
    allow(fake_client).to receive(:get).with(/.*sets/) { set_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=TMS&page=1"
    ) { tms_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=TMS&page=2"
    ) { tms_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=TMS&page=3"
    ) { tms_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=TMS&page=4"
    ) { tms_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=TMS&page=5"
    ) { tms_response }

    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=ATS&page=1"
    ) { ats_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=ATS&page=2"
    ) { ats_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=ATS&page=3"
    ) { ats_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=ATS&page=4"
    ) { ats_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=ATS&page=5"
    ) { ats_response }

    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=YAS&page=1"
    ) { yas_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=YAS&page=2"
    ) { yas_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=YAS&page=3"
    ) { yas_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=YAS&page=4"
    ) { yas_response }
    allow(fake_client).to receive(:get).with(
      "#{ENV['MAGIC_API_ROOT_URL']}cards?set=YAS&page=5"
    ) { yas_response }
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
        expect(retrieved_card.border).to eq('black')
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
