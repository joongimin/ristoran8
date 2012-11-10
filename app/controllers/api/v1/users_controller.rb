class Api::V1::UsersController < Api::V1::ApplicationController
  def login
    email = params[:email]
    password = params[:password]

    if email.nil? or password.nil?
      render :json => {:error => t("error.invalid_email_or_password")}
      return
    end

    @user = User.find_by_email(email.downcase)

    if @user.nil?
      render :json => {:error => t("error.invalid_email_or_password")}
      return
    end

    if @user.valid_password?(password)
      @user.ensure_authentication_token!
      render :json => {:token => @user.authentication_token}.merge(@user.api_data)
      user_id = current_user.nil? ? 0 : current_user.id
      cookies[:user] = user_id
    else
      render :json => {:error => t("error.invalid_email_or_password")}
    end
  end

  def logout
    @user = User.find_by_authentication_token(params[:token])
    if @user.nil?
      render :status => 404, :json => {:error => t("error.invalid_request")}
      cookies[:user] = -1
    else
      cookies[:user] = -1
      @user.reset_authentication_token!
      render :status => 200, :json => {}
    end
  end

  def login_with_token
    @user = User.find_by_authentication_token(params[:token])
    if @user.nil?
      render :status => 404, :json => {}
    else
      @user.on_login_with_mobile
      render :status => 200, :json => @user.api_data
      send_login_event("Mobile")
      user_id = current_user.nil? ? 0 : current_user.id
      cookies[:user] = user_id
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.ensure_authentication_token!
      render :status => 200, :json => {:token => @user.authentication_token}.merge(@user.api_data)
    else
      error = @user.errors.first
      render :status => 404, :json => {:error => error.first.to_s.titleize + ' ' + error.second}
    end
  end
end