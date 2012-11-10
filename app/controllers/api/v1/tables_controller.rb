class Api::V1::TablesController < Api::V1::ApplicationController
  before_filter :require_to_be_restaurant_owner

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
        format.json { respond_with_success }
      else
        format.json { respond_with_error }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table = Table.find(params[:id])
    @table.destroy

    respond_to do |format|
      format.json { respond_with_success }
    end
  end

  def login_as_table
    @current_user.generate_table_token!
    respond_to do |format|
      format.json { render :json => {:table_token => @current_user.table_token} }
    end
  end

  def active_order
    respond_do do |format|
      format.json { render :json => @current_table.active_order.api_data }
    end
  end
end