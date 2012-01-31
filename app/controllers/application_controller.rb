class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :require_login
  skip_before_filter :require_login, :only => [:home, :about, :standings]

  def home
    flash.keep
    redirect_to user_path(current_user) if current_user
  end

  def about
  end

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
