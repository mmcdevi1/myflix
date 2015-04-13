class ForgotPasswordsController < ApplicationController

  def new

  end

  def create
    user = User.where(email: params[:email]).first
    if user
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      if flash[:danger] = params[:email].blank?
        flash[:danger] = "Email cannot be blank."
      else
        flash[:danger] = "Email does not exist."
      end
      redirect_to forgot_password_path
    end
  end

  def confirm
  end

end
