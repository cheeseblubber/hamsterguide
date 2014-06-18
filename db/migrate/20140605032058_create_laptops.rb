class CreateLaptops < ActiveRecord::Migration
  def change
    create_table :laptops do |t|
      t.integer :ssd, null:false
      t.integer :display_size, null: false
      t.integer :ram, null: false
      t.integer :hdd, null: false
      t.integer :price, null: false
      t.float   :rating
      t.integer :num_of_reviews
      t.string  :cpu, null: false
      t.boolean :touchscreen, null: false, default: false
      t.boolean :dedicated_graphics, null:false, default: false
      t.timestamps
    end
  end
end
