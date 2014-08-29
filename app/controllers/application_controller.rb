class ApplicationController < ActionController::Base
  helper_method :current_user, :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def login!(user) 
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    # return nil unless session[:session_token]
#     @current_user ||=
    # User.find_by(session_token: session[:session_token])
    User.find_by_session_token(session[:session_token])
  end
  
  def require_login
    unless current_user
      redirect_to new_session_url 
      flash[:errors] = ["You must log in to access this feature"]
    end
  end
  
  def require_moderator
    sub = Sub.find(params[:id])
    unless current_user == sub.moderator
      redirect_to subs_url(sub) 
      flash[:errors] = ["You do not have permission to edit that sub"]
    end
  end
  
  def require_author
    post = Post.find(params[:id])
    unless current_user == post.author
      redirect_to subs_url(sub) 
      flash[:errors] = ["You do not have permission to edit that post"]
    end
  end
end
