class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def complete
    @order = @current_table.active_order
    @order.update_attribute(:order_status, OrderStatus::REQUESTED)
    @order.sub_orders.update_all(:order_status => OrderStatus::REQUESTED)

    advertisements = Advertisement.
      joins("inner join menu_items on menu_items.id = advertisements.menu_item_id").
      joins("inner join sub_orders on menu_items.id = sub_orders.menu_item_id").
      where("sub_orders.order_id = ?", @order.id)

    @advertisement = advertisements[rand(advertisements.length)]

    respond_to do |format|
      format.html {
        if @advertisement.nil?
          redirect_to @current_table.restaurant, notice: I18n.t("orders.complete")
        else
          redirect_to @advertisement, notice: I18n.t("orders.complete")
        end
      }
    end
  end

  def confirm
    @order = Order.find(params[:id])
    if !params[:sub_orders].nil?
      params[:sub_orders].each do |sub_order_data|
        sub_order_id = sub_order_data.first
        logger.debug "sub_order_id #{sub_order_id}"
        logger.debug "@order.sub_orders.find(sub_order_id) #{@order.sub_orders.find(sub_order_id)}"
        @order.sub_orders.find(sub_order_id).update_attribute(:order_status, OrderStatus::CONFIRMED)
        logger.debug "@order.sub_orders.find(sub_order_id).order_status #{@order.sub_orders.find(sub_order_id).order_status}"
      end
    end
    @order.update_attribute(:order_status, OrderStatus::CONFIRMED) if @order.sub_orders.where("order_status <> #{OrderStatus::CONFIRMED}").empty?
    respond_to do |format|
      format.html { redirect_to @order.restaurant, notice: I18n.t("orders.confirmed") }
    end
  end
end
