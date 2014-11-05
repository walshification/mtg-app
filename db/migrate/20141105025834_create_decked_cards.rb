class CreateDeckedCards < ActiveRecord::Migration
  def change
    create_table :decked_cards do |t|
      t.integer :deck_id
      t.integer :card_id

      t.timestamps
    end
  end
end
