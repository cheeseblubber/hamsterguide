class Addimageurls < ActiveRecord::Migration
  def change
    add_column :laptops, :small_image_url, :string
    add_column :laptops, :medium_image_url, :string
    add_column :laptops, :large_image_url, :string
  end
end
