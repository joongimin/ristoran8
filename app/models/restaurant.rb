class Restaurant < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :menu_categories
end
