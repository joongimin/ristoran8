class CreateSubOrders < ActiveRecord::Migration
  def change
    create_table :sub_orders do |t|
      t.references :order
      t.references :menu_item

      t.timestamps
    end
  end
end
