class ChangeCardTypeToTypesForCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :card_type, :string
    add_column :cards, :types, :string, array: true
  end
end
