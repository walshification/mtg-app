class ChangeFormatToLegalFormatAndColorsToColor < ActiveRecord::Migration
  def change
    rename_column :decks, :formats, :legal_format
    rename_column :decks, :colors, :color
  end
end
