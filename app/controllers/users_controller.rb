class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger]= "登録に失敗しました"
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def log_in(user)
    session[:user_id] = user.id
  end
  
  
end
