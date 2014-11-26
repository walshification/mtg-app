class Card < ActiveRecord::Base
  validates :deck_id, :presence => true
  
  belongs_to :user
  belongs_to :decks

  [:related_card_id, :set_number, :search_name, :description, :flavor, :colors, :mana_cost, :converted_mana_cost, :card_set_name, :card_type, :card_subtype, :power, :toughness, :loyalty, :rarity, :artist, :card_set_id, :token, :promo, :rulings, :formats, :released_at].each do |meth|
    define_method(meth) do
      @card_details ||= TolarianRegistry::Card.new(:multiverse_id => multiverse_id)
      @card_details.send(meth)
    end
  end

#   def self.find(multiverse_id)
#     Card.new(Unirest.get("http://api.mtgdb.info/cards/#{multiverse_id}").body)
#   end
end
