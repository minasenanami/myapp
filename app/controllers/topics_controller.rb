class TopicsController < ApplicationController
  def index
    @topics = Topic.all.includes(:favorite_users)
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
    @topic = Topic.find_by(params[:id])
  end
  
  private
  def topic_params
    params.require(:topic).permit(:title, :thumbnail, {image: []}, :contents)
  end
  
end
