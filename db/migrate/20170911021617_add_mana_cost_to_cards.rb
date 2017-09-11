class AddManaCostToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :mana_cost, :string
  end
end
