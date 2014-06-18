class Addwidth < ActiveRecord::Migration
  def change
    add_column :laptops, :width, :integer
  end
end
