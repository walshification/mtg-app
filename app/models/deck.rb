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

class Deck < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  belongs_to :user
  has_many :cards, through: :deck_card
  has_many :deck_card
end
