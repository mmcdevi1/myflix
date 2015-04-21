require 'spec_helper'

feature 'User resets password' do 
  let(:user) { Fabricate(:user, password: 'old_password') }
  scenario 'user successfully resets the password' do 
    visit login_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: user.email 
    click_button "Send Email"

    open_email(user.email)
    current_email.click_link("Reset my password")

    fill_in "New Password", with: "newpassword"
    click_button "Reset Password"

    fill_in "Email Address", with: user.email 
    fill_in "Password", with: "newpassword"
    click_button "Sign in"
    expect(page).to have_content(user.full_name)
  end
end