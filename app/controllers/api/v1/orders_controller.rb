class Api::V1::OrdersController < Api::V1::ApplicationController
  before_filter :require_to_be_table, :only => [:complete]
  before_filter :require_to_be_restaurant_owner, :only => [:index, :confirm]

  def index
    result = {}

    result[:orders] = []
    @current_restaurant.requested_orders.each do |order|
      result[:orders] << order.api_data
    end

    respond_to do |format|
      format.json { render :json => result }
    end
  end

  def complete
    @order = @current_table.active_order
    @order.update_attribute(:order_status, OrderStatus::REQUESTED)
    @order.sub_orders.update_all(:order_status => OrderStatus::REQUESTED)

    respond_to do |format|
      format.json { respond_with_success }
    end
  end

  def confirm
    @order = Order.find(params[:id])
    if !params[:sub_orders].nil?
      params[:sub_orders].each do |sub_order_data|
        sub_order_id = sub_order_data.first
        @order.sub_orders.find(sub_order_id).update_attribute(:order_status, OrderStatus::CONFIRMED)
      end
    end
    @order.update_attribute(:order_status, OrderStatus::CONFIRMED) if @order.sub_orders.where("order_status <> #{OrderStatus::CONFIRMED}").empty?
    respond_to do |format|
      format.json { respond_with_success }
    end
  end
end