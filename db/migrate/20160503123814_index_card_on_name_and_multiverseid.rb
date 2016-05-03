class IndexCardOnNameAndMultiverseid < ActiveRecord::Migration
  def change
    rename_column :cards, :card_name, :name
    change_column :cards, :name, :string, null: false
    rename_column :cards, :card_subtype, :subtype
    rename_column :cards, :card_text, :text
    change_column :cards, :multiverse_id, :integer, null: false
    remove_column :cards, :mana_cost, :string
    remove_timestamps :cards

    add_index :cards, :multiverse_id, unique: true
  end
end
