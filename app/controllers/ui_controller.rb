class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index
    @videos = Video.all
  end

  def show 
    @video = Video.find(params[:id])
  end

  def home 
    @categories = Category.all
    @videos = Video.all
  end
end
