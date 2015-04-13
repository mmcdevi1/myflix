require 'spec_helper'

describe ForgotPasswordsController do
  let(:user) { Fabricate(:user) }

  describe "POST create" do 
    context "with blank input" do 
      it "redirects to the forgot password page" do 
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end

      it "shows flash error message" do 
        post :create, email: ""
        expect(flash[:danger]).to eq("Email cannot be blank.")
      end
    end

    context "with existing email" do 
      it "redirects to the forgot_passwords_confirmation path" do 
        post :create, email: user.email
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends out an email to the email address" do 
        post :create, email: user.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
      end
    end

    context "with non-existing email" do 
      it "redirects to the forgot password page" do 
        post :create, email: "foo@bar.com"
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do 
        post :create, email: "foo@bar.com"
        expect(flash[:danger]).to eq("Email does not exist.")
      end
    end
  end
end
