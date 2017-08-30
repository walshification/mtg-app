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

require 'rails_helper'

RSpec.describe CardsController, type: :controller do

end
