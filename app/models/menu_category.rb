class MenuCategory < ActiveRecord::Base
  attr_accessible :name, :description, :restaurant_id, :image

  belongs_to :restaurant
  has_many :menu_items
  mount_uploader :image, ImageUploader

  def user
    restaurant.user
  end

  def api_data
    result = {
      :menu_category_id => id,
      :name => name,
      :description => description
    }

    if image?
      result[:image_url] = image_url
    end

    result[:menu_item] = []
    menu_items.each do |menu_item|
      result[:menu_item] << menu_item.api_data
    end

    result
  end
end
