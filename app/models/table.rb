class Table < ActiveRecord::Base
  attr_accessible :position, :restaurant_id
  belongs_to :restaurant
  has_many :orders

  validates :position, :uniqueness => {:scope => :restaurant_id}
  validates :position, :presence => :true

  def active_order
    if orders.empty? || orders.last.order_status != OrderStatus::PENDING
      Order.create(:order_status => OrderStatus::PENDING, :table => self)
    else
      orders.last
    end
  end
end