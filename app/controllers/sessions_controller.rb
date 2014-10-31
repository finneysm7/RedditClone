class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:username],
      params[:user][:password])
    if @user.save
      log_user_in!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid username/password"]
      redirect_to new_session_url
    end
  end
  
  def destroy
    log_out_user!
    redirect_to new_session_url
  end
end
