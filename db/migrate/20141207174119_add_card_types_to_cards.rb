class AddCardTypesToCards < ActiveRecord::Migration[4.2]
  def change
    add_column :cards, :card_type, :string
    add_column :cards, :card_subtype, :string
  end
end
