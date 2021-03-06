class Restaurant < ActiveRecord::Base
  attr_accessible :description, :name, :images_attributes, :user_id

  belongs_to :user
  has_many :menu_categories
  has_many :images, :as => :imageable
  has_many :tables
  has_many :orders, :through => :tables

  accepts_nested_attributes_for :images, :allow_destroy => true

  validates :user_id, :presence => :true

  def requested_orders
    orders.where(:order_status => OrderStatus::REQUESTED)
  end

  def api_list_data
    result = {
      :restaurant_id => id,
      :name => name,
      :description => description,
    }

    if !images.empty?
      result[:image_url] = images.first.image_url
      result[:small_image_url] = images.first.image_url(:small)
    end

    result
  end

  def api_data
    result = {
      :restaurant_id => id,
      :name => name
    }

    result[:menu_categories] = []
    menu_categories.each do |menu_category|
      result[:menu_categories] << menu_category.api_data
    end

    result[:tables] = []
    tables.each do |table|
      result[:tables] << table.api_data
    end

    if !images.empty?
      result[:image_url] = images.first.image_url
    end

    result
  end
end