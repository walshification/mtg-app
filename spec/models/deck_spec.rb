require 'rails_helper'

describe Deck, :type => :model do

  let(:user) {
    User.create(
      email: "test@example.com",
      password: "foooooopassword",
      password_confirmation: "foooooopassword",
    )
  }

  describe "#new" do
    it "makes a new deck with name" do
      expect(Deck.new(name: "New Deck")).to be_valid
    end

    it "is invalid without a name" do
      deck = Deck.new()
      deck.save()
      expect(deck.errors[:name]).to include("can't be blank")
    end

    it "is invalid if name is not unique" do
      Deck.create(name: "New Deck", user_id: user.id)
      deck = Deck.new(name: "New Deck", user_id: user.id)
      deck.save()
      expect(deck.errors[:name]).to include("has already been taken")
    end
  end

  describe "#create" do
    it "associates a created deck with the user who made it" do
      deck = Deck.create(name: "New Deck", user_id: user.id)
      expect(user.decks.first.id).to eq(deck.id)
    end

    it "contains associated card objects" do
      deck = Deck.create(name: "New Deck", user_id: user.id)
      card = Card.create(
        name: "Foo Card",
        deck_id: deck.id,
        multiverse_id: "foo_multiverse_id",
      )
      expect(deck.cards.first.id).to eq(card.id)
    end

    it "doesn't include cards associated with other decks" do
      first_deck = Deck.create(name: "New Deck", user_id: user.id)
      second_deck = Deck.create(name: "Second Deck", user_id: user.id)
      first_card = Card.create(
        name: "Foo Card",
        deck_id: first_deck.id,
        multiverse_id: "first_card_id",
      )
      second_card = Card.create(
        name: "Foo Card",
        deck_id: second_deck.id,
        multiverse_id: "second_card_id",
      )
      expect(first_deck.cards).to_not include(second_card)
    end
  end
end
