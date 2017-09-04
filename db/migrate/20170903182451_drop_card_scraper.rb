class DropCardScraper < ActiveRecord::Migration[5.1]
  def change
    drop_table :card_scrapers
  end
end
