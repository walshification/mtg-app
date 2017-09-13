# frozen_string_literal: true

require 'rails_helper'

describe MagicApiClient, type: :model do
  let(:api_fixtures) { YAML.load_file('spec/fixtures/magic_api_responses.yml') }

  describe '.get_sets' do
    let(:two_sets) { api_fixtures['two_sets'] }
    let(:single_set) { { sets: [sets_response.first] } }
    let(:unicode_set) { api_fixtures['unicode_set'] }

    before(:each) do
      stub_request(:any, /sets/).and_return(
        body: two_sets.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    it 'returns an array of JSON Magic sets' do
      response = described_class.get_sets
      expect(response.length).to eq(2)
      expect(response.first['code']).to eq('TMS')
      expect(response.second['code']).to eq('ATS')
    end

    it 'finds the sets if they are not in the database already' do
      response = described_class.get_sets(codes: ['TMS'])
      expect(response.length).to eq(1)
      expect(response.first['code']).to eq('TMS')
    end

    it 'returns only specific sets if sets are specified' do
      stub_request(:get, /sets\?name=Test%20Magic%20Set/).and_return(
        body: two_sets.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      create(:magic_set, name: 'Test Magic Set', code: 'TMS')
      response = described_class.get_sets(codes: ['TMS'])
      expect(response.length).to eq(1)
      expect(response.first['code']).to eq('TMS')
    end

    # regression test against a bug
    it 'properly handles unicode characters in set names' do
      stub_request(:get, /sets\?name=Magic:%20tGConspiracy/).and_return(
        body: unicode_set.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      create(:magic_set, name: "Magic: tG\u2014Conspiracy", code: 'UCS')
      response = described_class.get_sets(codes: ['UCS'])
      expect(response.length).to eq(1)
      expect(response.first['name']).to eq("Magic: tG\u2014Conspiracy")
    end
  end

  describe '.get_set' do
    it 'returns a single set from a code' do
      stub_request(:get, %r{sets\/TMS}).and_return(
        body: api_fixtures['single_set'].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      response = described_class.get_set('TMS')
      expect(response['name']).to eq('Test Magic Set')
    end

    it 'returns a 404 error if asked for a set that does not exist' do
      stub_request(:get, %r{sets\/FAKE}).and_return(
        body: { 'status' => '404', 'error' => 'Not Found' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      response = described_class.get_set('FAKE')
      expect(response['status']).to eq('404')
      expect(response['error']).to eq('Not Found')
    end
  end

  describe '.get_cards' do
    let(:tms_cards) { api_fixtures['tms_cards'] }

    before(:each) do
      stub_request(:get, 'https://api.magic.com/cards')
        .with(query: { set: 'TMS', page: 1 })
        .and_return(
          body: tms_cards['page_one'].to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, 'https://api.magic.com/cards')
        .with(query: { set: 'TMS', page: 2 })
        .and_return(
          body: { cards: [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns an array of JSON Magic cards found in a given set' do
      response = described_class.get_cards('TMS')
      expect(response.count).to eq(100)
      expect(response.first['name']).to eq('some card')
    end

    it 'finds multiple pages of cards' do
      stub_request(:get, 'https://api.magic.com/cards')
        .with(query: { set: 'TMS', page: 2 })
        .and_return(
          body: tms_cards['page_two'].to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, 'https://api.magic.com/cards')
        .with(query: { set: 'TMS', page: 3 })
        .and_return(
          body: { cards: [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      response = described_class.get_cards('TMS')
      expect(response.count).to eq(101)
    end
  end

  describe '.get_card' do
    it 'finds a single card if given a multiverse ID' do
      stub_request(:get, 'https://api.magic.com/cards/4175')
        .and_return(
          body: api_fixtures['yas_card'].to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      response = described_class.get_card(4175)
      expect(response['name']).to eq('Counterspell')
    end

    it 'returns a 404 error if asked for a card that does not exist' do
      stub_request(:get, %r{cards\/FAKE}).and_return(
        body: { 'status' => '404', 'error' => 'Not Found' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      response = described_class.get_card('FAKE')
      expect(response['status']).to eq('404')
      expect(response['error']).to eq('Not Found')
    end
  end
end