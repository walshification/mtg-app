require 'rails_helper'

describe Card, :type => :model do

  let(:new_card) { Card.new(name: "New Card", multiverse_id: "new_card") }

  describe "#new" do
    it "is valid with a name and multiverse_id" do
      expect(new_card.valid?).to be_truthy
    end

    it "is invalid without a name" do
      new_card.update(name: nil)
      new_card.valid?

      expect(new_card.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a multiverse_id" do
      new_card.update(multiverse_id: nil)
      new_card.valid?

      expect(new_card.errors[:multiverse_id]).to include("can't be blank")
    end

    it "is invalid without if multiverse_id is not unique" do
      old_card = Card.create(name: "Old Card", multiverse_id: "card")
      new_card.update(multiverse_id: "card")
      new_card.valid?

      expect(new_card.errors[:multiverse_id]).to include("has already been taken")
    end
  end
end
