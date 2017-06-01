class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    session[:return_to] ||= request.referer
    session[:return_to] ||= root_path
    unless logged_in?
      flash[:error] = "You must be logged in to see this page"
      redirect_to session.delete(:return_to)
    end
  end

  def is_admin?
    session[:return_to] ||= request.referer
    session[:return_to] ||= root_path
    unless @current_user.admin
      flash[:error] = "You must be an admin to access this section of the site."
      redirect_to session.delete(:return_to)
    end
  end
end
