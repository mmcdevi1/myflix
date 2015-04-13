class VideosController < ApplicationController
  before_action :require_user
  
  def index
    @videos = Video.first
    @categories = Category.all
  end

  def new
    @video = Video.new
  end

  def show
    @video = Video.find_by_token(params[:id])
    @reviews = @video.reviews
  end

  def search
    @results = Video.search_by_title(params[:search])
  end
end
