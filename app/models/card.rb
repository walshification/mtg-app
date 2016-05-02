# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  multiverse_id :integer
#  deck_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  card_name     :string(255)
#  image_url     :string(255)
#  card_type     :string(255)
#  card_subtype  :string(255)
#

class Card < ActiveRecord::Base
  # validates :deck_id, :presence => true

  belongs_to :user
  belongs_to :decks
end
