class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_session_info

  def set_session_info
    @current_table = Table.find(session[:table]) if session[:table]
    @current_restaurant = Restaurant.find(params[:restaurant_id]) if params.include?(:restaurant_id)
  end

  def require_to_be_restaurant_owner
    if !@current_table.nil?
      sign_out(current_user)
    end
    authenticate_user!
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
