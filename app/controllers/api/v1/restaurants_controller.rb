class Api::V1::RestaurantsController < Api::V1::ApplicationController
  def index
    result = {}
    result[:restaurants] = []
    current_user.restaurants.each do |restaurant|
      result[:restaurants] << restaurant.api_list_data
    end

    respond_to do |format|
      format.json { render :json => result }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.json { render :json => @restaurant.api_data }
    end
  end
end