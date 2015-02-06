class UsersController < ApplicationController

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have registered successfully!"
      redirect_to login_path
    else
      render 'new'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

end
