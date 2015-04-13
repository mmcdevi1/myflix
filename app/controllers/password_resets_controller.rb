class PasswordResetsController < ApplicationController
  def show
    user = User.where(token: params[:id]).first
    user ? (@token = user.token) : (redirect_to expired_token_path)
  end

  def expired_token

  end

  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      user.generate_token
      user.save
      flash[:success] = "Password updated."
      redirect_to login_path
    else
      redirect_to expired_token_path
    end
  end

end
