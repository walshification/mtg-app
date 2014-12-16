json.cards @deck.cards.each do |card|
  json.card_name card.card_name
  json.id card.id
  json.deck_id card.deck_id
  json.image_url card.image_url
  json.multiverse_id card.multiverse_id
  json.card_type card.card_type
  json.card_subtype card.card_subtype
end