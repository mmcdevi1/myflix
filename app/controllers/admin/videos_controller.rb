class Admin::VideosController < AdminsController
	def new
		@video = Video.new
	end

	def create
		@video = Video.new(video_params)
		if @video.save
			flash[:success] = "Video uploaded"
			redirect_to new_admin_video_path
		else
			flash[:danger] = "Error uploading video"
			render 'new'
		end
	end

	private

	def video_params
		params.require(:video).permit(:title, :description, :category_id, :image)
	end
end