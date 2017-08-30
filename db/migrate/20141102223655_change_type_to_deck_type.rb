class ChangeTypeToDeckType < ActiveRecord::Migration[4.2]
  def change
    rename_column :decks, :type, :deck_type
  end
end
