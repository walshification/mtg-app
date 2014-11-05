class Deck < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user
  has_many :decked_cards
  has_many :cards, :through => :decked_cards
end
