class SubOrder < ActiveRecord::Base
  attr_accessible :menu_item_id, :order, :count, :order_status
  belongs_to :order
  belongs_to :menu_item

  def api_data
    {
      :sub_order_id => id,
      :menu_item => menu_item.api_data
    }
  end
end
