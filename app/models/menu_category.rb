class MenuCategory < ActiveRecord::Base
  attr_accessible :name, :restaurant_id

  belongs_to :restaurant
  has_many :menu_items

  def user
    restaurant.user
  end
end
