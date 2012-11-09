class MenuCategoriesController < ApplicationController
  before_filter :require_to_be_restaurant_owner, :except => [:index, :show]

  # GET /menu_categories
  # GET /menu_categories.json
  def index
    @menu_categories = MenuCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menu_categories }
    end
  end

  # GET /menu_categories/1
  # GET /menu_categories/1.json
  def show
    @menu_category = MenuCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu_category }
    end
  end

  # GET /menu_categories/new
  # GET /menu_categories/new.json
  def new
    @menu_category = MenuCategory.new(:restaurant_id => params[:restaurant_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu_category }
    end
  end

  # GET /menu_categories/1/edit
  def edit
    @menu_category = MenuCategory.find(params[:id])
  end

  # POST /menu_categories
  # POST /menu_categories.json
  def create
    @menu_category = MenuCategory.new(params[:menu_category])

    respond_to do |format|
      if @menu_category.save
        format.html { redirect_to "/", notice: 'Menu category was successfully created.' }
        format.json { render json: @menu_category, status: :created, location: @menu_category }
      else
        format.html { render action: "new" }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menu_categories/1
  # PUT /menu_categories/1.json
  def update
    @menu_category = MenuCategory.find(params[:id])

    respond_to do |format|
      if @menu_category.update_attributes(params[:menu_category])
        format.html { redirect_to @menu_category.restaurant, notice: 'Menu category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_categories/1
  # DELETE /menu_categories/1.json
  def destroy
    @menu_category = MenuCategory.find(params[:id])
    @menu_category.destroy

    respond_to do |format|
      format.html { redirect_to menu_categories_url }
      format.json { head :no_content }
    end
  end
end
