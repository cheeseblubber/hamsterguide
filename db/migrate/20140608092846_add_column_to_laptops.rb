class AddColumnToLaptops < ActiveRecord::Migration
  def change
    add_column :laptops, :asin_id, :string
  end
end
