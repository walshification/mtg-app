# frozen_string_literal: true

# Gathers Magic cards.
class Gatherer
  def initialize(client: HTTParty, set_codes: nil)
    @api_root = ENV['MAGIC_API_ROOT_URL']
    @set_codes = set_codes || []
    @client = client
  end

  def gather
    gathered_sets.collect(&:code)
                 .each do |set_code|
      save_cards(set_code)
    end
  end

  private

  def gathered_sets
    existing_sets = MagicSet.where(code: @set_codes)
    return existing_sets if gathered?(existing_sets)
    unsaved_sets = get_from_api('sets')
    save_sets(unsaved_sets)
    @set_codes.any? ? MagicSet.where(code: @set_codes) : MagicSet.all
  end

  def gathered?(existing_sets)
    existing_sets.any? && existing_sets.count == @set_codes.count
  end

  def get_from_api(query)
    resp_key = query.include?('?') ? query.split('?').first : query
    @client.get("#{@api_root}#{query}").parsed_response[resp_key]
  end

  def save_sets(sets)
    sets.map do |magic_set|
      save_set(magic_set)
    end
  end

  def save_set(magic_set)
    MagicSet.find_or_create_by(
      block: magic_set['block'],
      border: magic_set['border'],
      code: magic_set['code'],
      gatherer_code: magic_set['gathererCode'],
      magiccards_info_code: magic_set['magicCardsInfoCode'],
      name: magic_set['name'],
      online_only: magic_set.fetch('online_only', false),
      release_date: magic_set['releaseDate'],
      set_type: magic_set['type']
    )
  end

  def save_cards(set_code)
    set_cards = gather_cards(set_code)
    Card.import(set_cards)
  end

  def gather_cards(set_code)
    page = 1
    set_cards = []
    5.times do
      set_cards += get_from_api("cards?set=#{set_code}&page=#{page}")
      page += 1
    end
    filter_duplicate_cards(set_cards, MagicSet.find_by(code: set_code))
  end

  def filter_duplicate_cards(set_cards, magic_set)
    new_cards = set_cards.map { |card| record_card(card, magic_set) }
                         .uniq(&:multiverse_id)
    new_cards.reject do |card|
      Card.where(multiverse_id: card.multiverse_id).any?
    end
  end

  # rubocop:disable MethodLength, AbcSize
  def record_card(card, magic_set)
    Card.new(
      name: card['name'],
      multiverse_id: card['multiverseid'],
      magic_set_id: magic_set.id,
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
      border: card['border'] || magic_set.border,
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
