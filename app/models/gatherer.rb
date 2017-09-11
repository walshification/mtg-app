# frozen_string_literal: true

# Gathers Magic cards.
class Gatherer
  def initialize(client: MagicApiClient, set_codes: nil)
    @client = client
    @set_codes = set_codes || []
  end

  def gather
    gathered_sets.collect(&:code).each do |set_code|
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
      @client.get_sets.reject do |unsaved_set|
        existing_set_codes.include?(unsaved_set['code']) ||
          @set_codes.exclude?(unsaved_set['code'])
      end
    else
      @client.get_sets.reject do |unsaved_set|
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

  def save_sets(sets)
    sets.map { |magic_set| MagicSet.from_api(magic_set) }
  end

  def save_cards(set_code)
    set_cards = @client.get_cards(set_code)
    filtered_cards = filter_duplicate_cards(set_cards)
    magic_set = MagicSet.find_by(code: set_code)
    card_objs = filtered_cards.map { |card| Card.from_api(card, magic_set) }
    Card.import(card_objs)
  end

  def filter_duplicate_cards(set_cards)
    set_cards.uniq { |card| card['multiverseid'] }
             .reject { |card| Card.where(multiverse_id: card['multiverseid']).any? }
  end

  # TODO
  def calculate_missing_card_values; end
end
