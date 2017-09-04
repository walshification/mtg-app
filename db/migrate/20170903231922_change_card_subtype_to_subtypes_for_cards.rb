class ChangeCardSubtypeToSubtypesForCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :subtype, :string
    add_column :cards, :subtypes, :string, array: true
  end
end
