json.cards @deck.cards.each do |card|
  json.card_name card.card_name
  json.image_url card.image_url
  json.multiverse_id card.multiverse_id
end