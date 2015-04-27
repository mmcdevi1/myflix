class Admin::VideosController < AdminsController
	def new
		@video = Video.new
	end

	def create
		#some change
	end
end