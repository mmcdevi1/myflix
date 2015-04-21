require 'spec_helper'

describe InvitationsController do
  let(:user) { Fabricate(:user) }

  describe "GET new" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      it "sets @invitations to a new invitations" do 
        get :new
        expect(assigns(:invitation)).to be_new_record
        expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end

    context "unauthenticated users" do 
      it "redirects to the login page" do 
        get :new 
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id 
      end

      context "with valid inputs" do 
        after { ActionMailer::Base.deliveries.clear }
        
        before do 
          post :create, invitation: { 
            recipient_name: "Joe Smith", 
            recipient_email: "joe@smith.com", 
            message: "hello world",
            inviter_id: user.id
          }
        end

        it "redirects to the invitation page" do 
          expect(response).to redirect_to new_invitation_path
        end

        it "creates an invitation" do 
          expect(Invitation.count).to eq(1)
        end

        it "sends an email to the recipient" do 
          expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@smith.com'])
        end
        
        it "sets the flash success message" do 
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid inputs" do 
        before do 
          post :create, invitation: { 
            recipient_email: "joe@smith.com", 
            message: "hello world",
            inviter_id: user.id
          }
        end

        it "renders the new template" do 
          expect(response).to render_template :new
        end

        it "does not create an invitation" do 
          expect(Invitation.count).to eq(0)
        end

        it "does not send out an email" do 
          expect(ActionMailer::Base.deliveries).to be_empty
        end

        it "sets @invitation" do 
          expect(assigns(:invitation)).to be_present
        end
      end
    end 
  end
end
