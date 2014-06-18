class Removecolumns < ActiveRecord::Migration
  def change
    remove_column :laptops, :num_of_reviews
    remove_column :laptops, :rating
    add_column :laptops, :length, :integer
    add_column :laptops, :thinkness, :integer
    add_column :laptops, :os, :string
  end
end
