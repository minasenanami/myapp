class ApplicationController < ActionController::Base
  
  before_action :set_current_user
  
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def authenticate_user
    if @current_user == nil
      flash.now[:danger] = "ログインをお願いします"
      redirect_to login_path
    end
  end
  
  def forbid_login_user
    if @current_user
      flash.now[:danger] = "すでにログインしています"
      redirect_to root_path
    end
  end
  
end
