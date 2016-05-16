class DropCardsDecksTable < ActiveRecord::Migration
  def change
    drop_table :cards_decks
  end
end
