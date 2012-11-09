class Users::SessionsController < Devise::SessionsController
  def create
    session[:table] = nil
    super
  end

  def destroy
    session[:table] = nil
    super
  end
end
