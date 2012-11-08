class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_status
      t.references :sub_orders

      t.timestamps
    end
  end
end
