# frozen_string_literal: true

# Gathers Magic cards.
class Gatherer
  def initialize(client: HTTParty, set_codes: nil)
    @api_root = ENV['MAGIC_API_ROOT_URL']
    @client = client
    @set_codes = set_codes || []
  end

  def gather
    gathered_sets.collect(&:code)
                 .each do |set_code|
      save_cards(set_code)
    end
    calculate_missing_card_values
  end

  private

  def gathered_sets
    return existing_sets unless unsaved_sets.any?
    existing_sets + save_sets(unsaved_sets)
  end

  def unsaved_sets
    if @set_codes.any?
      get_from_api('sets').reject do |unsaved_set|
        existing_set_codes.include?(unsaved_set['code']) ||
          @set_codes.exclude?(unsaved_set['code'])
      end
    else
      get_from_api('sets').reject do |unsaved_set|
        existing_set_codes.include?(unsaved_set['code'])
      end
    end
  end

  def existing_set_codes
    @existing_set_codes ||= existing_sets.collect(&:code)
  end

  def existing_sets
    @existing_sets ||= @set_codes.any? ? MagicSet.where(code: @set_codes) : MagicSet.all
  end

  def get_from_api(query)
    resp_key = query.include?('?') ? query.split('?').first : query
    @client.get("#{@api_root}#{query}").parsed_response[resp_key]
  end

  def save_sets(sets)
    sets.map { |magic_set| save_set(magic_set) }
  end

  def save_set(magic_set)
    MagicSet.from_api(magic_set)
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
    new_cards = set_cards.map { |card| Card.from_api(card, magic_set) }
                         .uniq(&:multiverse_id)
    new_cards.reject do |card|
      Card.where(multiverse_id: card.multiverse_id).any?
    end
  end

  # TODO
  def calculate_missing_card_values; end
end
