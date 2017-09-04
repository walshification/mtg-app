class ChangeMultiverseIdForCardsToNumber < ActiveRecord::Migration[5.1]
  def up
    change_column :cards, :multiverse_id, 'integer USING CAST(multiverse_id AS integer)'
  end

  def down
    change_column :cards, :multiverse_id, :string
  end
end
