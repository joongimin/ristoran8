# coding: utf-8

class SubOrdersController < ApplicationController
  def create
    @sub_order = @current_table.create_sub_order(params[:sub_order])

    respond_to do |format|
      if @sub_order.save
        format.html { redirect_to restaurant_path(@current_table.restaurant), notice: "#{@sub_order.menu_item.name} 1개를 추가하였습니다. 주문을 모두 선택하셨으면 \"주문 완료\"를 클릭해주세요." }
      else
        format.html { redirect_to restaurant_path(@current_table.restaurant), alert: "#{@sub_order.menu_item.name}를 주문하지 못했습니다. 직원에게 문의해주세요." }
      end
    end
  end

  def increment
    @sub_order = SubOrder.find(params[:id])
    @sub_order.increment! :count
  end

  def decrement
    @sub_order = SubOrder.find(params[:id])
    @sub_order.decrement! :count
    if @sub_order.count == 0
      @sub_order_id = @sub_order.id
      @sub_order.destroy
      @sub_order = nil
    end
  end
end