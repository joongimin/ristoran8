class Api::V1::ApplicationController < ActionController::Base
protected
  before_filter :set_session_info

  def set_session_info
    @current_table = User.find_by_table_token(params[:table_token]) if !params[:table_token].nil?
    @current_restaurant = Restaurant.find(params[:restaurant_id]) if params.include?(:restaurant_id)
  end

  def current_user
    @current_user ||= User.find_by_authentication_token(params[:token])
  end

  def respond_with_success
    render :json => {}
  end

  def respond_with_error(error_message = nil)
    render :json => {:error => error_message}, :status => 403
  end

  def require_to_be_restaurant_owner
    respond_with_error(t("error.not_authorized")) if @current_restaurant.user != current_user
  end

  def is_user?
    @current_table.nil? && !current_user.nil?
  end
  helper_method :is_user?

  def is_table?
    !@current_table.nil?
  end
  helper_method :is_table?
end