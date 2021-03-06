class MenuItem < ActiveRecord::Base
  attr_accessible :description, :name, :price, :menu_category_id, :images_attributes
  belongs_to :menu_category
  has_many :images, :as => :imageable
  has_many :advertisements

  accepts_nested_attributes_for :images, :allow_destroy => true

  def user
    menu_category.user
  end

  def api_data
    result = {
      :menu_item_id => id,
      :name => name,
      :price => price
    }

    if !images.empty?
      result[:image_url] = images.first.image_url
    end

    result
  end
end