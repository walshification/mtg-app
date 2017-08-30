require 'rails_helper'

describe Deck, :type => :model do

  let(:user) { create(:user,
                      email: 'test@example.com',
                      password: 'foooooopassword',
                      password_confirmation: 'foooooopassword') }

  describe '#new' do
    it 'makes a new deck with name' do
      expect(Deck.new(name: 'New Deck', user_id: user.id)).to be_valid
    end

    it 'is invalid without a name' do
      deck = Deck.new()
      deck.save()
      expect(deck.errors[:name]).to include("can't be blank")
    end

    it 'is invalid if name is not unique to the user' do
      Deck.create(name: 'New Deck', user_id: user.id)
      deck = Deck.new(name: 'New Deck', user_id: user.id)
      deck.save()
      expect(deck.errors[:name]).to include('has already been taken')
    end

    it 'is valid if another user has a deck with the same name' do
      new_user = User.create(
        email: 'another_test@example.com',
        password: 'barrrrrrrpassword',
        password_confirmation: 'barrrrrrrpassword',
      )
      Deck.create(name: 'New Deck', user_id: user.id)
      new_user_deck = Deck.new(name: 'New Deck', user_id: new_user.id)
      expect(new_user_deck).to be_valid
    end
  end

  describe '#create' do
    it 'associates a created deck with the user who made it' do
      deck = Deck.create(name: 'New Deck', user_id: user.id)
      expect(user.decks.first.id).to eq(deck.id)
    end

    it 'does not include cards associated with other decks' do
      some_set = MagicSet.create(name: 'some set')
      first_card = create(
        :card,
        name: 'Foo Card',
        multiverse_id: 'first_card_id',
        magic_set_id: some_set.id
      )
      second_card = create(
        :card,
        name: 'Another Card',
        multiverse_id: 'second_card_id',
        magic_set_id: some_set.id
      )
      first_deck = create(:deck, name: 'New Deck', user_id: user.id)
      second_deck = create(:deck, name: 'Second Deck', user_id: user.id)
      create(:deck_card, deck_id: first_deck.id, card_id: first_card.id)
      create(:deck_card, deck_id: second_deck.id, card_id: second_card.id)
      expect(first_deck.cards).to_not include(second_card)
    end
  end
end
