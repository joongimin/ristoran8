class Restaurant < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :menu_categories
  has_many :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true
end
