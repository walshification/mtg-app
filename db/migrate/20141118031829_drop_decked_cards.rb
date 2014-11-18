class DropDeckedCards < ActiveRecord::Migration
  def up
    drop_table :decked_cards
  end

  def down
    create_table :decked_cards do |t|
      t.integer :deck_id
      t.integer :card_id
      t.integer :quantity

      t.timestamps
    end
    add_index :tablenames, :anothertable_id
  end
end
