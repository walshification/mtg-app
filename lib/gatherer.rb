# frozen_string_literal: true

require 'httparty'

# Gathers Magic cards.
class Gatherer
  def initialize(client = HTTParty)
    @api_root = ENV['MAGIC_API_ROOT_URL']
    @sets = nil
    @client = client
  end

  def gather
    sets = get_from_api('sets')
    save_sets(sets)
    set_codes = sets.collect { |magic_set| magic_set['code'] }
    set_codes.each do |set_code|
      save_cards(set_code)
    end
  end

  private

  def get_from_api(query)
    resp_key = query.include?('?') ? query.split('?').first : query
    @client.get("#{@api_root}#{query}").parsed_response[resp_key]
  end

  def save_sets(sets)
    sets.each do |magic_set|
      save_set(magic_set)
    end
  end

  def save_set(magic_set)
    MagicSet.find_or_create_by(
      name: magic_set['name'],
      code: magic_set['code'],
      magiccards_info_code: magic_set['magicCardsInfoCode'],
      border: magic_set['border'],
      set_type: magic_set['type'],
      block: magic_set['block'],
      release_date: magic_set['releaseDate'],
      online_only: magic_set.fetch('online_only', false)
    )
  end

  def save_cards(set_code)
    set_cards = get_from_api("cards?set=#{set_code}")
    magic_set = MagicSet.find_by(code: set_code)
    set_cards.each do |card|
      save_card(card, magic_set)
    end
  end

  # rubocop:disable MethodLength, AbcSize
  def save_card(card, magic_set)
    Card.find_or_create_by(
      name: card['name'],
      multiverse_id: card['multiverseid'],
      magic_set: magic_set,
      image_url: card['imageUrl'],
      types: card['types'],
      subtypes: card['subtypes'],
      layout: card['layout'],
      cmc: card['cmc'],
      rarity: card['rarity'],
      text: card['text'],
      flavor: card['flavor'],
      artist: card['artist'],
      number: card['number'],
      power: card['power'],
      toughness: card['toughness'],
      loyalty: card['loyalty'],
      watermark: card['watermark'],
      border: card['border'],
      timeshifted: card['timeshifted'],
      hand: card['hand'],
      life: card['life'],
      reserved: card.fetch('reserved', false),
      release_date: card['release_date'],
      starter: card.fetch('starter', false),
      original_text: card['original_text'],
      original_type: card['original_type'],
      source: card['source']
    )
  end
  # rubocop:enable MethodLength, AbcSize
end

Gatherer.new.gather if $PROGRAM_NAME == __FILE__
