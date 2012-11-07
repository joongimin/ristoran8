class MenuItem < ActiveRecord::Base
  attr_accessible :description, :name, :price, :menu_category_id
  belongs_to :menu_category
end
