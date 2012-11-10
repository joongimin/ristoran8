class Api::V1::SubOrdersController < Api::V1::ApplicationController
  def create
    @sub_order = @current_table.create_sub_order(params[:sub_order])

    respond_to do |format|
      format.json {
        if @sub_order.save
          respond_with_success
        else
          respond_with_error
        end
      }
    end
  end

  def increment
    @sub_order = SubOrder.find(params[:id])
    @sub_order.increment! :count
    respond_with_success
  end

  def decrement
    @sub_order = SubOrder.find(params[:id])
    @sub_order.decrement! :count
    if @sub_order.count == 0
      @sub_order_id = @sub_order.id
      @sub_order.destroy
      @sub_order = nil
    end
    respond_with_success
  end
end