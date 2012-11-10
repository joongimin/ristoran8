class AddOrderStatusToSubOrders < ActiveRecord::Migration
  def change
    add_column :sub_orders, :order_status, :integer
  end
end