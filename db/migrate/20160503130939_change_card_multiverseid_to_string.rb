class ChangeCardMultiverseidToString < ActiveRecord::Migration[4.2]
  def change
    change_column :cards, :multiverse_id, :string
  end
end
