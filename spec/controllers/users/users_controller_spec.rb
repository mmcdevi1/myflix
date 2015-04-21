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
      after { ActionMailer::Base.deliveries.clear }

      before do 
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do 
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do 
        expect(response).to redirect_to login_path
      end

      # it "allows the user to follow the inviter" do 
      #   invitation = Fabricate(:invitation, inviter: user, recipient_email: 'joe@smith.com')
      #   post :create, user: { email: "joe@smith.com", password: "password" }, invitation_token: invitation.token
      #   joe = User.where(email: "joe@smith.com").first
      #   expect(joe.follows?(user)).to be_true
      # end

      it "allows the inviter to follow the user"
      it "expires the invitation upon acceptance"

      context "email sending" do 
        it "sends out the email" do 
          ActionMailer::Base.deliveries.should_not be_empty
        end

        it "sends to the right recipient" do 
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([User.last.email])
        end

        it "has the right content" do 
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include(User.last.full_name)
        end
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

      it "does not send an email" do 
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET new_with_invitation_token" do 
    let(:invitation) { Fabricate(:invitation) }

    it "renders the new view template" do 
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it "sets @user with recipient email" do 
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it "sets @invitation_token" do 
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects to expired token page for invalid tokens" do 
      get :new_with_invitation_token, token: "hasdf"
      expect(response).to redirect_to expired_token_path
    end
  end

end







































