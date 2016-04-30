# == Schema Information
#
# Table name: decks
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string(255)
#  legal_format :string(255)
#  deck_type    :string(255)
#  color        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Deck < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user
  has_many :cards
end
