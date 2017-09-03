# frozen_string_literal: true

# Web scraper for Magic cards
class Gatherer
  ATTRS = %w[
    name
    cmc
    layout
    rarity
    text
    flavor
    artist
    number
    power
    toughness
    loyalty
    watermark
    border
    timeshifted
    hand
    life
    reserved
    release_date
    starter
    original_text
    original_type
    source
    code
    border
    block
    set_type
    gatherer_code
    magiccards_info_code
    online_only
    multiverse_id
    image_url
  ].freeze

  CONVERTER = {
    card: {
      multiverseid: 'multiverse_id',
      imageUrl: 'image_url',
      type: 'card_type',
      manaCost: 'mana_cost'
    },
    set: {
      type: 'set_type',
      gathererCode: 'gatherer_code',
      magicCardsInfoCode: 'magiccards_info_code',
      releaseDate: 'release_date',
      onlineOnly: 'online_only'
    }
  }.freeze

  def initialize(client = HTTParty)
    @api_root = ENV['MAGIC_API_ROOT_URL']
    @sets = nil
    @client = client
  end

  def gather
    sets.each do |magic_set|
      cards_in(set(magic_set.code))
    end
  end

  private

  def sets
    @sets ||= get_from_api('sets')
  end

  def set(desired_set)
    sets.select { |set| set.code == desired_set }.first
  end

  def cards_in(desired_set)
    get_from_api("cards?set=#{set(desired_set).code}")
  end

  def get_from_api(query)
    resp_key = query.include?('?') ? query.split('?').first : query
    objs = @client.get("#{@api_root}#{query}").parsed_response[resp_key.to_sym]
    doublecheck_these(objs)
  end

  def doublecheck_these(things)
    if things.first.dig('multiverseid')
      query_key = 'multiverse_id'
      klass = Card
    else
      query_key = 'code'
      klass = MagicSet
    end
    things.map { |thing| doublecheck_this(thing, klass, query_key) }
  end

  def doublecheck_this(thing, klass, query_key)
    db_thing = klass.find_by(query_key => thing[query_key])
    return db_thing if db_thing
    send('collect', thing, klass)
  end

  def collect(thing, klass)
    klass.create(convert(thing))
  end

  def convert(thing)
    type = thing.dig('multiverseid') ? :card : :set
    thing.keys.each_with_object({}) do |api_attr, converted|
      converter_key = CONVERTER[type].dig(api_attr.to_sym)
      key = converter_key ? converter_key : api_attr
      converted[key] = thing.dig(api_attr) if ATTRS.include?(key)
    end
  end
end
