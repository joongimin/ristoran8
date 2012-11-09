class MenuItemsController < ApplicationController
  before_filter :require_to_be_restaurant_owner, :except => [:show]

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu_item }
    end
  end

  # GET /menu_items/new
  # GET /menu_items/new.json
  def new
    @menu_item = MenuItem.new(:menu_category_id => params[:menu_category_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu_item }
    end
  end

  # GET /menu_items/1/edit
  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(params[:menu_item])

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to [@menu_item.menu_category.restaurant, @menu_item.menu_category, @menu_item], notice: 'Menu item was successfully created.' }
        format.json { render json: @menu_item, status: :created, location: @menu_item }
      else
        format.html { render action: "new" }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menu_items/1
  # PUT /menu_items/1.json
  def update
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      if @menu_item.update_attributes(params[:menu_item])
        format.html { redirect_to [@menu_item.menu_category.restaurant, @menu_item.menu_category, @menu_item], notice: 'Menu item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to menu_items_url }
      format.json { head :no_content }
    end
  end
end
