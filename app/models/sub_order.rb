class SubOrder < ActiveRecord::Base
  attr_accessible :menu_item_id, :order, :count, :order_status
  belongs_to :order
  belongs_to :menu_item
end
