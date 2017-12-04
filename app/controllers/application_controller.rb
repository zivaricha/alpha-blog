class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end
  
  def logged_in?
    !!current_user
  end
  
  # this method will be used to restrict certian actions and links for logged in users only
  def require_user
    if !logged_in?
      flash[:danger] = "You have to be logged in to perform this action"
      redirect_to root_path
    end
  end
end
