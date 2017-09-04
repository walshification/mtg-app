# frozen_string_literal: true

# Join table for assigning cards to decks
class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card
end

# == Schema Information
#
# Table name: deck_cards
#
# *id*::      <tt>integer, not null, primary key</tt>
# *deck_id*:: <tt>integer</tt>
# *card_id*:: <tt>integer</tt>
#
# Indexes
#
#  index_deck_cards_on_card_id  (card_id)
#  index_deck_cards_on_deck_id  (deck_id)
#--
# == Schema Information End
#++
