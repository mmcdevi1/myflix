class QueueItemsController < ApplicationController
  before_action :require_user
  
  def index
    @queue_items = current_user.queue_items.all
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video)    
    redirect_to queue_path    
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def queue_video(video)
    unless current_user_queued_video?(video)
      QueueItem.create(video: video, user: current_user, position: new_queue_item_position) 
    end
  end
end