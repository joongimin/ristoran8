class Order < ActiveRecord::Base
  attr_accessible :order_status, :table, :sub_orders_attributes
  belongs_to :table
  has_many :sub_orders

  accepts_nested_attributes_for :sub_orders

  def restaurant
    table.restaurant
  end
end
