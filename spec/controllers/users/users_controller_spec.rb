require 'spec_helper'

describe UsersController do
  let(:user) { Fabricate(:user) }

  describe "GET new" do 
    it "sets @user" do 
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET show" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      it "sets @user" do 
        get :show, id: user.id
        expect(assigns(:user)).to eq(user)
      end

      it "renders the show template" do 
        get :show, id: user.id 
        expect(response).to render_template 'show'
      end
    end

    context "unauthenticated users" do 

    end
  end

  describe "POST create" do 
    context "with valid input" do 
      before do 
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do 
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do 
        expect(response).to redirect_to login_path
      end
    end

    context "with invalid input" do 
      before do 
        post :create, user: { password: "password", full_name: "Mike mcdevitt" }
      end

      it "does not create the user" do 
        expect(User.count).to eq(0)
      end

      it "renders the new template" do 
        expect(response).to render_template :new
      end

      it "sets @user" do 
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

end
