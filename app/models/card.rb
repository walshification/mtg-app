# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  multiverse_id :integer
#  deck_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  card_name     :string(255)
#  image_url     :string(255)
#  card_type     :string(255)
#  card_subtype  :string(255)
#

class Card < ActiveRecord::Base
  validates :deck_id, :presence => true

  belongs_to :decks

  [:editions, :text, :flavor, :colors, :mana_cost, :converted_mana_cost, :card_set_name, :power, :toughness, :loyalty, :rarity, :artist, :card_set_id, :rulings, :formats].each do |meth|
    define_method(meth) do
      @card_details ||= TolarianRegistry::Card.new(:multiverse_id => multiverse_id)
      @card_details.send(meth)
    end
  end


end
