class Advertisement < ActiveRecord::Base
  attr_accessible :description, :name, :menu_item_id, :images_attributes

  belongs_to :menu_item
  has_many :images, :as => :imageable

  accepts_nested_attributes_for :images, :allow_destroy => true

  def user
    menu_item.user
  end
end
