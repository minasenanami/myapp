class TopicsController < ApplicationController
  before_action :authenticate_user, {only: [:new, :show]}
  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
  
  def index
    @topics = Topic.all.includes(:favorite_users).page(params[:page]).per(3)
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render:new
    end
  end
  
  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @topics = Topic.search(params[:search])
  end
  
  def show
    @topic = Topic.find_by(id: params[:id])
  end
  
  def edit
    @topic = Topic.find_by(id: params[:id])
  end
  
  def update
    @topic = Topic.find_by(id: params[:id])
    if @topic.update_attributes(topic_params)
      redirect_to topic_path, success: '編集が完了しました'
    else
      flash.now[:danger] = "編集の保存に失敗しました"
      rednder :edit
    end
  end
  
  def destroy
    topic = Topic.find_by(params[:id])
    if topic.user_id == current_user.id
      topic.destroy
      redirect_to root_path, success: '投稿を削除しました'
    end
  end
  
  def ensure_correct_user
    @topic = Topic.find_by(id: params[:id])
    if @topic.user_id != @current_user.id
      flash.now[:danger] = '権限がありません'
      redirect_to root_path
    end
  end
  
  private
  def topic_params
    params.require(:topic).permit(:title, :thumbnail, {image: []}, :contents)
  end
  
end
