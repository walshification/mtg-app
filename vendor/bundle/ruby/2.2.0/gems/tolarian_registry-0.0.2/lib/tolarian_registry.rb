require "tolarian_registry/version"
require 'unirest'

module TolarianRegistry
  class Card
    attr_accessor :multiverse_id, :related_card_id, :set_number, :card_name, :search_name, :description, :flavor, :colors, :mana_cost, :converted_mana_cost, :card_set_name, :card_type, :card_subtype, :power, :toughness, :loyalty, :rarity, :artist, :card_set_id, :token, :promo, :rulings, :formats, :released_at

    def initialize(hash)
      @multiverse_id = hash[:multiverse_id]
      api_hash = Unirest.get("http://api.mtgdb.info/cards/#{@multiverse_id}").body
      @related_card_id = api_hash["relatedCardId"]
      @set_number = api_hash["setNumber"]
      @card_name = api_hash["name"]
      @search_name = api_hash["searchName"]
      @description = api_hash["description"]
      @flavor = api_hash["flavor"]
      @colors = api_hash["colors"]
      @mana_cost = api_hash["manaCost"]
      @converted_mana_cost = api_hash["convertedManaCost"]
      @card_set_name = api_hash["cardSetName"]
      @card_type = api_hash["type"]
      @card_subtype = api_hash["subType"]
      @power = api_hash["power"]
      @toughness = api_hash["toughness"]
      @loyalty = api_hash["loyalty"]
      @rarity = api_hash["rarity"]
      @artist = api_hash["artist"]
      @card_set_id = api_hash["cardSetId"]
      @token = api_hash["token"]
      @promo = api_hash["promo"]
      @rulings = api_hash["rulings"]
      @formats = api_hash["formats"]
      @released_at = api_hash["releasedAt"]
    end

    def low_price
      @price = get_price("low")
    end

    def median_price
      @price = get_price("median")
    end

    def high_price
      @price = get_price("high")
    end

    private

    def get_price(level)
      @card = Unirest.get("https://api.deckbrew.com/mtg/cards?multiverseid=#{@multiverse_id}").body
      @card[0]["editions"].each do |edition|
        @price = edition["price"][level] if edition["multiverse_id"] == @multiverse_id
      end
      @price
    end

  end
end
