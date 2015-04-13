require 'spec_helper'

describe PasswordResetsController do
  let(:user) { Fabricate(:user) }

  describe "GET show" do 
    it "renders show template fi the token is valid" do 
      user.update_column(:token, '123456')
      get :show, id: "123456"
      expect(response).to render_template :show
    end

    it "redirects to the expired token page if the token is not valid" do 
      get :show, id: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do 
    context "with valid token" do 
      it "redirects to the sign in page"  do 
        user.update_column(:token, "123456")
        post :create, token: "123456", password: "newpassword"
        expect(response).to redirect_to login_path
      end

      # it "updates the users password" do 
      #   user.update_column(:token, "123456")
      #   post :create, token: "123456", password: "newpassword"
      #   expect(user.reload.authenticate("newpassword")).to be_true
      # end
      
      it "sets the flash success message" do 
        user.update_column(:token, "123456")
        post :create, token: "123456", password: "newpassword"
        expect(flash[:success]).to be_present
      end

      it "regenerates the user token" do 
        user.update_column(:token, "123456")
        post :create, token: "123456", password: "newpassword"
        expect(user.reload.token).not_to eq('123456')
      end
    end

    context "with invalid token" do 
      it "redirects to the expired token path" do 
        post :create, token: '12345', password: "some"
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
