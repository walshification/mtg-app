# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeckCard, type: :model do
  let(:user) do
    User.create(
      email: 'test@example.com',
      password: 'foooooopassword',
      password_confirmation: 'foooooopassword'
    )
  end

  it 'ties card objects to a specified deck' do
    deck = Deck.create(name: 'New Deck', user_id: user.id)
    card = Card.create(
      name: 'Foo Card',
      multiverse_id: 'foo_multiverse_id',
      magic_set_id: create(:magic_set).id
    )
    DeckCard.create(deck_id: deck.id, card_id: card.id)
    expect(deck.cards.first.id).to eq(card.id)
  end
end
