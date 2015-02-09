require 'spec_helper'

describe UsersController do 
  describe "GET new" do 
    it "sets the @user variable" do 
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do 
    context "with valid inputs" do 
      before do 
        post :create, user: { full_name: "Mike", 
                              email: "email@email.com", 
                              password: "password" }
      end

      it "creates a user" do 
        expect(User.count).to eq(1)
      end

      it "redirects to the login path" do 
        expect(response).to redirect_to login_path
      end
    end

    context "with invalid inputs" do 
      before do 
        post :create, user: { full_name: "", 
                              email: "email@email.com", 
                              password: "password" }
      end

      it "does not create a user" do 
        expect(User.count).to eq(0)
      end

      it "renders the new template" do 
        expect(response).to render_template :new
      end

      it "sets @user variable" do 
        get :new
        expect(assigns(:user)).to be_instance_of(User)
      end
    end  
  end
end 