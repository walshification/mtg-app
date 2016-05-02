class CreateCardScrapers < ActiveRecord::Migration
  def change
    create_table :card_scrapers do |t|

      t.timestamps null: false
    end
  end
end
