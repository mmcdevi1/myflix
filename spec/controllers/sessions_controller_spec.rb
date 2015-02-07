require 'spec_helper'

describe SessionsController do
  describe "GET new" do 
    it "renders the new template for unauthenticated users" do 
      get :new 
      response.should render_template :new
    end

    it "redirects to the home page for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      get :new
      response.should redirect_to home_path
    end
  end

  describe "POST create" do 
    context "with valid credentials" do 
      before do 
        @alice = Fabricate(:user)
        post :create, email: @alice.email, password: @alice.password
      end

      it "puts the signed in user in the session" do 
        expect(session[:user_id]).to eq(@alice.id)
      end

      it "redirects to the home page" do 
        response.should redirect_to home_path
      end 

      it "sets the flash success message" do 
        expect(flash[:success]).to eq("You are signed in, enjoy!")
      end
    end 

    context "with invalid credentials" do 
      before do 
        @alice = Fabricate(:user)
        post :create, email: @alice.email, password: @alice.password + 'asdfadf'
      end

      it "does not put the signed in user in the session" do 
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign in page" do 
        response.should redirect_to login_path
      end

      it "sets the flash danger message" do 
        expect(flash[:danger]).to eq("Invalid email or password")
      end
    end
  end 

  describe "GET destroy" do 
    before do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clears the user session" do 
      expect(session[:user_id]).to be_nil
    end

    it "redirect_to root_path" do 
      response.should redirect_to root_path
    end

    it "sets the flash success" do 
      expect(flash[:success]).to eq("You have been logged out.")
    end
  end
end








































