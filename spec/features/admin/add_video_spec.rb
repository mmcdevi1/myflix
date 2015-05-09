require 'spec_helper'

describe 'admin adding a video' do 
	let(:admin) { Fabricate(:user, admin: true) }

	context "authenciated admins" do 
		before do 
			visit login_path
			fill_in :email, with: admin.email
			fill_in :password, with: admin.password
			click_button "Sign in"
		end

		it 'admin successfully adds a new video' do 
			comedy = Category.create(name: "Comedy")
			visit new_admin_video_path
			fill_in "Title", with: "Monk"
			select("Comedy", :from => "Category")
			fill_in "Description", with: "description"
			click_button "Add Video"

			visit video_path(Video.last)
			expect(page).to have_content("Monk")
		end
	end
end