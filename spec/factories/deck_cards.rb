# frozen_string_literal: true
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deck_card do
  end
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
