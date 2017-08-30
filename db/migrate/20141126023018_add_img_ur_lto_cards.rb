class AddImgUrLtoCards < ActiveRecord::Migration[4.2]
  def change
    add_column :cards, :image_url, :string
  end
end
