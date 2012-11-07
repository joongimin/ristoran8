class MenuCategory < ActiveRecord::Base
  attr_accessible :name, :restaurant_id

  belongs_to :restaurant
  has_many :menu_items
end
