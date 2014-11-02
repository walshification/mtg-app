class ChangeTypeToDeckType < ActiveRecord::Migration
  def change
    rename_column :decks, :type, :deck_type
  end
end
