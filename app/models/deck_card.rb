# == Schema Information
#
# Table name: deck_cards
#
#  id      :integer          not null, primary key
#  deck_id :integer
#  card_id :integer
#
# Indexes
#
#  index_deck_cards_on_card_id  (card_id)
#  index_deck_cards_on_deck_id  (deck_id)
#

class DeckCard < ActiveRecord::Base
  belongs_to :deck
  belongs_to :card
end