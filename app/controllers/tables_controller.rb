class TablesController < ApplicationController
  before_filter :require_to_be_restaurant_owner

  # GET /tables/new
  # GET /tables/new.json
  def new
    @table = Table.new(:restaurant_id => params[:restaurant_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @table }
    end
  end

  # GET /tables/1/edit
  def edit
    @table = Table.find(params[:id])
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(params[:table])

    respond_to do |format|
      if @table.save
        format.html { redirect_to @table.restaurant, notice: 'Table was successfully created.' }
        format.json { render json: @table, status: :created, location: @table }
      else
        format.html { render action: "new" }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tables/1
  # PUT /tables/1.json
  def update
    @table = Table.find(params[:id])

    respond_to do |format|
      if @table.update_attributes(params[:table])
        format.html { redirect_to @table.restaurant, notice: 'Table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table = Table.find(params[:id])
    @table.destroy

    respond_to do |format|
      format.html { redirect_to @table.restaurant }
      format.json { head :no_content }
    end
  end

  def login_as_table
    @table = Table.find(params[:id])
    session[:table] = @table.id
    respond_to do |format|
      format.html { redirect_to @table.restaurant }
      format.json { head :no_content }
    end
  end
end
