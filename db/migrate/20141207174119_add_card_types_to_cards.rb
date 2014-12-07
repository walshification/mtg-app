class AddCardTypesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_type, :string
    add_column :cards, :card_subtype, :string
  end
end
