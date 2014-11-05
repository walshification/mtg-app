class Card < ActiveRecord::Base
  validates :name, :presence => true
  
  belongs_to :deck
  has_many :decked_cards
  has_many :decks, :through => :decked_cards
end
