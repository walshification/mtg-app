require 'rails_helper'

describe Card, :type => :model do
  let(:magic_set) { create(:magic_set) }
  let(:new_card) { Card.new(name: 'New Card', multiverse_id: 'new_card', magic_set_id: magic_set.id) }

  describe '#new' do
    it 'is valid with a name, multiverse_id, and magic_set_id' do
      expect(new_card.valid?).to be_truthy
    end

    it 'is invalid without a name' do
      new_card.update(name: nil)
      new_card.valid?
      expect(new_card.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a multiverse_id' do
      new_card.update(multiverse_id: nil)
      new_card.valid?
      expect(new_card.errors[:multiverse_id]).to include("can't be blank")
    end

    it 'is invalid without a magic_set_id' do
      new_card.update(magic_set_id: nil)
      new_card.valid?
      expect(new_card.errors[:magic_set]).to include('must exist')
    end

    it 'is invalid if multiverse_id is not unique' do
      new_card.save
      newer_card = Card.new(name: 'Newer Card', multiverse_id: 'new_card', magic_set_id: magic_set.id)
      newer_card.valid?
      expect(newer_card.errors[:multiverse_id]).to include('has already been taken')
    end
  end
end
