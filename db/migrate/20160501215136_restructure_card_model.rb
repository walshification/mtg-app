class RestructureCardModel < ActiveRecord::Migration
  def change
    add_column :cards, :layout, :string
    add_column :cards, :mana_cost, :string
    add_column :cards, :cmc, :integer
    add_column :cards, :rarity, :string
    add_column :cards, :card_text, :text
    add_column :cards, :flavor, :string
    add_column :cards, :artist, :string
    add_column :cards, :number, :string
    add_column :cards, :power, :string
    add_column :cards, :toughness, :string
    add_column :cards, :loyalty, :integer
    add_column :cards, :set_id, :integer
    add_column :cards, :watermark, :string
    add_column :cards, :border, :string
    add_column :cards, :timeshifted, :boolean
    add_column :cards, :hand, :string
    add_column :cards, :life, :string
    add_column :cards, :reserved, :boolean
    add_column :cards, :release_date, :string
    add_column :cards, :starter, :boolean
    add_column :cards, :original_text, :text
    add_column :cards, :original_type, :string
    add_column :cards, :source, :string
  end
end
