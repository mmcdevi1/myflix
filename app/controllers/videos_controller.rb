class VideosController < ApplicationController
  def index
    @videos = Video.all
    @categories = Category.all
  end

  def new
  end

  def show
    @video = Video.find(params[:id])
  end
end
