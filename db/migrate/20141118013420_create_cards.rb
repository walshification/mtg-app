class CreateCards < ActiveRecord::Migration[4.2]
  def change
    create_table :cards do |t|
      t.integer :multiverse_id
      t.integer :deck_id

      t.timestamps
    end
  end
end
