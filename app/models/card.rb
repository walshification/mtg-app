# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  multiverse_id :integer
#  deck_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  card_name     :string
#  image_url     :string
#  card_type     :string
#  card_subtype  :string
#  layout        :string
#  mana_cost     :string
#  cmc           :integer
#  rarity        :string
#  card_text     :text
#  flavor        :string
#  artist        :string
#  number        :string
#  power         :string
#  toughness     :string
#  loyalty       :integer
#  set_id        :integer
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
#

class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :decks
end
