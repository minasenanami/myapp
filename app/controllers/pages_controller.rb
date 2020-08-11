class PagesController < ApplicationController
  def index
     @topics = Topic.all.limit(10)
  end
end
