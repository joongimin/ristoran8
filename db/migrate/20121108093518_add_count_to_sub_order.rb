class AddCountToSubOrder < ActiveRecord::Migration
  def change
    add_column :sub_orders, :count, :integer
  end
end
