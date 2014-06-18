class Url < ActiveRecord::Migration
  def change
    add_column :laptops, :url, :string
    add_index :laptops, :asin_id, unique: true
    change_column :laptops, :asin_id, :string, null: false
    change_column :laptops, :width, :integer, null: false
  end
end
