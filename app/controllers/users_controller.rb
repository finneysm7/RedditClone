class UsersController < ApplicationController
  
  def index
    @users = User.all
    render :index
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_user_in!(@user)
      redirect_to subs_url ## change
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end
