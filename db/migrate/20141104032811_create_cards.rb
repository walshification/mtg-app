class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :multiverse_id
      t.integer :related_card_multiverse_id
      t.integer :set_number
      t.string :name
      t.string :search_name
      t.text :description
      t.text :flavor
      t.string :mana_cost
      t.integer :converted_mana_cost
      t.string :card_set_name
      t.string :card_type
      t.string :card_subtype
      t.integer :power
      t.integer :toughness
      t.integer :loyalty
      t.string :rarity
      t.string :artist
      t.string :card_set_abbreviated_name
      t.boolean :token
      t.boolean :promo
      t.date :released_at

      t.timestamps
    end
  end
end
