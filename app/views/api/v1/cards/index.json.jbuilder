# frozen_string_literal: true

json.array! @cards do |card|
  json.id card.id
  json.multiverse_id card.multiverse_id
  json.name card.name
  json.image_url card.image_url
  json.types card.types
  json.subtypes card.subtypes
  json.layout card.layout
  json.cmc card.cmc
  json.rarity card.rarity
  json.text card.text
  json.flavor card.flavor
  json.artist card.artist
  json.number card.number
  if card.types.include?('Creature')
    json.power card.power
    json.toughness card.toughness
  end
  json.loyalty card.loyalty
  json.watermark card.watermark
  json.border card.border
  json.timeshifted card.timeshifted
  if card.types.include?('Vanguard')
    json.hand card.hand
    json.life card.life
  end
  json.reserved card.reserved
  json.release_date card.release_date
  json.starter card.starter
  json.original_text card.original_text
  json.original_type card.original_type
  json.source card.source
  json.set_id card.magic_set_id

  json.set do
    json.id card.magic_set.id
    json.name card.magic_set.name

  end
  # json.name @message.creator.name.familiar
  # json.email_address @message.creator.email_address_with_name
  # json.url url_for(@message.creator, format: :json)
end

# if current_user.admin?
#   json.visitors calculate_visitors(@message)
# end

# json.comments @message.comments, :content, :created_at

# json.attachments @message.attachments do |attachment|
#   json.filename attachment.filename
#   json.url url_for(attachment)
# end
