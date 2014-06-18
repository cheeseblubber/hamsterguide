class Removedisplaysize < ActiveRecord::Migration
  def change
    remove_column :laptops, :display_size
  end
end
