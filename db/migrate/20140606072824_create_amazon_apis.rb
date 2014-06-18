class CreateAmazonApis < ActiveRecord::Migration
  def change
    create_table :amazon_apis do |t|

      t.timestamps
    end
  end
end
