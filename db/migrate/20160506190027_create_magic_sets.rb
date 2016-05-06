class CreateMagicSets < ActiveRecord::Migration
  def change
    create_table :magic_sets do |t|
      t.string :name
      t.string :code
      t.string :gatherer_code
      t.string :magiccards_info_code
      t.string :border
      t.string :set_type
      t.string :block
      t.string :release_date
      t.boolean :online_only, default: false
    end
  end
end
