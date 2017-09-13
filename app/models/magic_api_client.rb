# frozen_string_literal: true

# Client wrapper for the Magic: The Gathering API.
class MagicApiClient
  class UnknownQuery < StandardError; end

  def self.get_sets(codes: nil)
    return get('sets') if codes.nil?
    select_by_code(codes)
  end

  def self.get_set(set_code)
    get("sets/#{set_code}")
  end

  def self.get_cards(set_code)
    (1..5).inject([]) do |cards, page_number|
      pre_call_count = cards.count
      cards += get("cards?set=#{set_code}&page=#{page_number}")
      break cards if no_more_cards?(pre_call_count, cards.count)
      cards
    end
  end

  def self.get_card(multiverse_id)
    get("cards/#{multiverse_id}")
  end

  private_class_method

  def self.get(query)
    resp_key = parse_for_response_key(query)
    response = HTTParty.get("#{ENV['MAGIC_API_ROOT_URL']}#{query}").parsed_response
    return response if response['status'] == '404'
    response[resp_key]
  end

  def self.select_by_code(codes)
    requested_set_names = MagicSet.where(code: codes).pluck(:name)
    returned_sets = get_sets_from_names(requested_set_names)
    returned_sets.select { |api_set| codes.include?(api_set['code']) }
  end

  def self.parse_for_response_key(query)
    path = query.split('?').first
    return path unless path.include?('/')
    path.split('/').first[0..-2]
  end

  def self.allowed?(resp_key)
    %w[cards sets].include?(resp_key)
  end

  def self.get_sets_from_names(requested_set_names)
    if requested_set_names.any?
      set_names_query = safe_names(requested_set_names).join('|')
      get("sets?name=#{set_names_query}")
    else
      get('sets')
    end
  end

  def self.safe_names(unsafe_names)
    unsafe_names.collect do |unsafe_name|
      unsafe_name.encode(
        Encoding.find('ASCII'),
        invalid: :replace,
        undef: :replace,
        replace: '',
        universal_newline: true
      )
    end
  end

  def self.no_more_cards?(pre_call_count, cards_count)
    pre_call_count == cards_count || cards_count % 100 != 0
  end
end
