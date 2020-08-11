class UsersController < ApplicationController
  # ユーザーを認証する　ログインしている状態じゃないと入れない場所
  before_action :authenticate_user, {only: [:show]}
  
  # ログインユーザー禁止　すでにログインしている場合を特定の場所に弾く
  before_action :forbid_login_user, {only: [:new, :create,]}
  
  # 正しいユーザーか確認する ログインユーザーidと編集したいユーザーのidが同じか ユーザーの情報編集と更新時に使う予定
  # before_action :ensure_correct_user, {only: [:edit, :update]}
  
  
  def new
    @user = User.new
  end
  
  def show
    # @favorite_topics = current_user.favorite_topics.page(params[:page]).per(2)
    @users = current_user.topics.page(params[:page]).per(6).order(:id)
    @user = User.find_by(id: params[:id])
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
