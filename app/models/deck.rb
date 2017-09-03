# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  legal_format :string
#  deck_type    :string
#  color        :string
#  created_at   :datetime
#  updated_at   :datetime
#

# Model representation of a deck of Magic cards.
class Deck < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  belongs_to :user
  has_many :deck_card
  has_many :cards, through: :deck_card
end
