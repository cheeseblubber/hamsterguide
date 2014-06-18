class FixThinknessname < ActiveRecord::Migration
  def change
    rename_column :laptops, :thinkness, :thickness
  end
end
