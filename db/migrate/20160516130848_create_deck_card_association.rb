class CreateDeckCardAssociation < ActiveRecord::Migration
  def change
    create_table :deck_cards do |t|
      t.belongs_to :deck, index: true
      t.belongs_to :card, index: true
    end
  end
end
