class Card < ActiveRecord::Base
  # validates :deck_id, :presence => true

  belongs_to :user
  belongs_to :decks
end
