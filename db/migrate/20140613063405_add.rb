class Add < ActiveRecord::Migration
  def change
    add_column :laptops, :detachable, :boolean
  end
end
