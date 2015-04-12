class UsersController < ApplicationController
  before_action :require_user, only: [:show]
  before_action :set_user, only: [:show]

  def new 
    @user = User.new
  end

  def show
    @queue_items = @user.queue_items.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver
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
