class MenuCategory < ActiveRecord::Base
  attr_accessible :name, :description, :restaurant_id

  belongs_to :restaurant
  has_many :menu_items

  def user
    restaurant.user
  end

  def api_data
    result = {
      :menu_category_id => id,
      :name => name
    }

    result[:menu_item] = []
    menu_items.each do |menu_item|
      result[:menu_item] << menu_item.api_data
    end

    result
  end
end
