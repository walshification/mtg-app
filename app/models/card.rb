class Card < ActiveRecord::Base
  validates :deck_id, :presence => true
  
  belongs_to :user
  belongs_to :decks

  [:editions, :text, :flavor, :colors, :mana_cost, :converted_mana_cost, :card_set_name, :power, :toughness, :loyalty, :rarity, :artist, :card_set_id, :rulings, :formats].each do |meth|
    define_method(meth) do
      @card_details ||= TolarianRegistry::Card.new(:multiverse_id => multiverse_id)
      @card_details.send(meth)
    end
  end

  
end
