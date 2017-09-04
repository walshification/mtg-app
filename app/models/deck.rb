# frozen_string_literal: true

# Model representation of a deck of Magic cards.
class Deck < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  belongs_to :user
  has_many :deck_card
  has_many :cards, through: :deck_card
end

# == Schema Information
#
# Table name: decks
#
# *id*::           <tt>integer, not null, primary key</tt>
# *user_id*::      <tt>integer</tt>
# *name*::         <tt>string</tt>
# *legal_format*:: <tt>string</tt>
# *deck_type*::    <tt>string</tt>
# *color*::        <tt>string</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#--
# == Schema Information End
#++
