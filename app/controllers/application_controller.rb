class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    return nil if session[:session_token].nil? 
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def log_user_in!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def log_out_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end 
  
  def logged_in?
    !current_user.nil?
  end
  
  def ensure_moderator!
    return if current_user.id == Sub.find(params[:id]).user_id
    redirect_to subs_url
  end
  
  def ensure_author!
    post = Post.find(params[:id])
    return if current_user.id == post.user_id
    redirect_to post_url(post)
  end
end
