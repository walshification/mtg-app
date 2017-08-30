class ChangeCardSetIdToMagicSetId < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :set_id, :integer
    add_column :cards, :magic_set_id, :integer
  end
end
