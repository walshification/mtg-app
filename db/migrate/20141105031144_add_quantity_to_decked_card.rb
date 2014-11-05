class AddQuantityToDeckedCard < ActiveRecord::Migration
  def change
    add_column :decked_cards, :quantity, :integer
  end
end
