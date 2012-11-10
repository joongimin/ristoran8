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

  def create_sub_order(args)
    order = active_order
    sub_order = order.sub_orders.where(:menu_item_id => args[:menu_item_id]).first
    if sub_order.nil?
      sub_order = SubOrder.new(args.merge(:order => order, :count => 1, :order_status => OrderStatus::PENDING))
    else
      sub_order.increment(:count)
    end

    sub_order
  end

  def api_data
    {
      :table_id => id,
      :position => position
    }
  end
end