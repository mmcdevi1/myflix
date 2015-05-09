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

	describe "POST create" do 
		context "authenticated admins" do 
			let(:category) { Category.create(name: "Horror") }
			before do 
				session[:user_id] = admin.id
			end

			context "with valid params" do 
				before do
					post :create, video: { title: "Monk", description: "description", category_id: category.id  }
				end

				it "redirects to the add new video page" do 
					expect(response).to redirect_to new_admin_video_path
				end

				it "creates a video" do 
					expect(Video.count).to eq(1)
				end

				it "sets the flash success message" do 
					expect(flash[:success]).to be_present
				end
			end

			context "with invalid params" do 
				before do 
					post :create, video: { title: "Monk", description: "", category_id: category.id  }
				end

				it "does not create a video" do 
					expect(Video.count).to eq(0)
				end

				it "renders the new template" do 
					expect(response).to render_template :new
				end

				it "sets the @video variable" do 
					expect(assigns(:video)).to be_present
				end

				it "sets the flash error message" do 
					expect(flash[:danger]).to be_present
				end
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












































