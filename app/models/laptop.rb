class Laptop < ActiveRecord::Base
  validates :asin_id, uniqueness: true

end
