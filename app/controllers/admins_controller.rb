class AdminsController < AuthenticatedController
	before_action :authenticate_admin

	private

	def authenticate_admin
		if !current_user.admin?
			flash[:danger] = "You are not authorized to view this page."
			redirect_to home_path unless current_user.admin?
		end
	end
end