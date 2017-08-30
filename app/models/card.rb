# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  multiverse_id :string           not null
#  deck_id       :integer
#  name          :string           not null
#  image_url     :string
#  card_type     :string
#  subtype       :string
#  layout        :string
#  cmc           :integer
#  rarity        :string
#  text          :text
#  flavor        :string
#  artist        :string
#  number        :string
#  power         :string
#  toughness     :string
#  loyalty       :integer
#  watermark     :string
#  border        :string
#  timeshifted   :boolean
#  hand          :string
#  life          :string
#  reserved      :boolean
#  release_date  :string
#  starter       :boolean
#  original_text :text
#  original_type :string
#  source        :string
#  magic_set_id  :integer
#
# Indexes
#
#  index_cards_on_multiverse_id  (multiverse_id) UNIQUE
#

class Card < ApplicationRecord
  validates :name, presence: true
  validates :multiverse_id, presence: true, uniqueness: true

  has_many :deck_card
  has_many :decks, through: :deck_card
  belongs_to :magic_set
end
