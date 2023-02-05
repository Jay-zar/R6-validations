class Order < ApplicationRecord
  belongs_to :customer

  validates :product_name, :product_count, :customer, presence:true
  validates_associated :customer
end
