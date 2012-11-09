class Order < ActiveRecord::Base
  attr_accessible :order_status, :table
  belongs_to :table
  has_many :sub_orders

  def restaurant
    table.restaurant
  end
end
