require 'spec_helper'

describe "User following" do 
  let(:user) { Fabricate(:user) }
  let(:bob)  { Fabricate(:user) }

  describe "user follows and unfollows another user" do 
    before do 
      visit login_path
      fill_in "Email Address", with: user.email 
      fill_in "Password",      with: user.password 
      click_button "Sign in"
      visit user_path(bob)
    end

    it "should allow user to follow bob" do 
      expect(page).to have_content("Follow")
      click_link "Follow"
      expect(page).to have_content(bob.full_name)
    end

    it "should allow a user to unfollow bob" do 
      expect(page).to have_content("Follow")
      click_link "Follow"
      visit people_path
      expect(page).to have_content(bob.full_name)
      unfollows(bob)
      expect(page).to_not have_content(bob.full_name) 
    end

    def unfollows(user)
      find("a[data-method='delete']").click
    end
  end
end