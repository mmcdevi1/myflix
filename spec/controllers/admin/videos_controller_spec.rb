require 'spec_helper'

describe Admin::VideosController do 
	let(:admin) { Fabricate(:user, admin: true) }
	let(:user)  { Fabricate(:user, admin: false) }
	
	describe "GET new" do 
		context "authenticated admins" do 
			before do 
				session[:user_id] = admin.id
			end

			it "sets the @video to a new variable" do 
				get :new
				expect(assigns(:video)).to be_instance_of Video
				expect(assigns(:video)).to be_new_record
			end
		end

		context "unauthenticated users" do 
			before do 
				session[:user_id] = user.id
			end

			it "redirects a regular user to the home path" do 
				get :new
				expect(response).to redirect_to home_path
			end

			it "sets the flash error message for regular user" do 
				get :new
				expect(flash[:danger]).to be_present
			end
		end
	end
end