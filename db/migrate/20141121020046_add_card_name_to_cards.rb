class AddCardNameToCards < ActiveRecord::Migration[4.2]
  def change
    add_column :cards, :card_name, :string
  end
end
