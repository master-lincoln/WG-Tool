class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def index
  end
  
  def about
  end
  
  def standings
  	@users = User.all
  end
  
end
