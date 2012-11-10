class Order < ActiveRecord::Base
  attr_accessible :order_status, :table, :sub_orders_attributes
  belongs_to :table
  has_many :sub_orders

  accepts_nested_attributes_for :sub_orders

  def restaurant
    table.restaurant
  end

  def api_data
    result = {
      :order_id => id
      :order_status => order_status
    }

    result[:sub_orders] = []
    sub_orders.each do |sub_order|
      result[:sub_orders] << sub_order.api_data
    end

    result
  end
end
