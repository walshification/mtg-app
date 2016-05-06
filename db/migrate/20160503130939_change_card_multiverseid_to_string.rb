class ChangeCardMultiverseidToString < ActiveRecord::Migration
  def change
    change_column :cards, :multiverse_id, :string
  end
end
