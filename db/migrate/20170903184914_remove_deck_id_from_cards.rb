class RemoveDeckIdFromCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :deck_id, :integer
  end
end
