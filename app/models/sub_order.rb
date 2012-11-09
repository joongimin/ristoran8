class SubOrder < ActiveRecord::Base
  attr_accessible :menu_item_id, :order, :count
  belongs_to :order
  belongs_to :menu_item
end
