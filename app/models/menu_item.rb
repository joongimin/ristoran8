class MenuItem < ActiveRecord::Base
  attr_accessible :description, :name, :price, :menu_category_id, :images_attributes
  belongs_to :menu_category
  has_many :images, :as => :imageable

  accepts_nested_attributes_for :images, :allow_destroy => true
end
