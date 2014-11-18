class Card < ActiveRecord::Base
  validates :deck_id, :presence => true
  
  belongs_to :user
  belongs_to :decks

#   attr_accessor :multiverse_id, :related_card_multiverse_id, :set_number, :name, :search_name, :description, :flavor, :mana_cost, :converted_mana_cost, :card_set_name, :card_type, :card_subtype, :power, :toughness, :loyalty, :rarity, :artist, :card_set_abbreviated_name, :token, :promo, :released_at

#   def initialize(hash)
#     @multiverse_id = hash["multiverse_id"]
#     @related_card_multiverse_id = hash["related_card_multiverse_id"]
#     @set_number = hash["set_number"]
#     @name = hash["name"]
#     @search_name = hash["search_name"]
#     @description = hash["description"]
#     @flavor = hash["flavor"]
#     @mana_cost = hash["mana_cost"]
#     @converted_mana_cost = hash["converted_mana_cost"]
#     @card_set_name = hash["card_set_name"]
#     @card_type = hash["card_type"]
#     @card_subtype = hash["card_subtype"]
#     @power = hash["power"]
#     @toughness = hash["toughness"]
#     @loyalty = hash["loyalty"]
#     @rarity = hash["rarity"]
#     @artist = hash["artist"]
#     @card_set_abbreviated_name = hash["card_set_abbreviated_name"]
#     @token = hash["token"]
#     @promo = hash["promo"]
#     @released_at = hash["released_at"]

#   def self.find(multiverse_id)
#     Card.new(Unirest.get("http://api.mtgdb.info/cards/#{multiverse_id}").body)
#   end
end
