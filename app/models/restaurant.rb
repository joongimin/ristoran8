class Restaurant < ActiveRecord::Base
  attr_accessible :description, :name, :images_attributes

  has_many :menu_categories
  has_many :images, :as => :imageable

  accepts_nested_attributes_for :images, :allow_destroy => true
end
