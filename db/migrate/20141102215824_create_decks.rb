class CreateDecks < ActiveRecord::Migration[4.2]
  def change
    create_table :decks do |t|
      t.integer :user_id
      t.string :name
      t.string :formats
      t.string :type
      t.string :colors

      t.timestamps
    end
  end
end
