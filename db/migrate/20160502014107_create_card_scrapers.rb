class CreateCardScrapers < ActiveRecord::Migration[4.2]
  def change
    create_table :card_scrapers do |t|

      t.timestamps null: false
    end
  end
end
