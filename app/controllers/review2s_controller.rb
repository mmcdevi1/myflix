class Review2sController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.review2s.new(review2s_params)
    @review.user = current_user
    if @review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private
  def review2s_params
    params.require(:review2).permit(:content, :rating, :video_id, :user_id)
  end

end
