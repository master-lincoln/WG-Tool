class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :require_login
  skip_before_filter :require_login, :only => [:home, :about]
  http_basic_authenticate_with :name => "wg", :password => ENV['HTTP_PASS'], :except => [:home, :feed]

  def home
    if current_user
      redirect_to user_path(current_user)
    else
      flash.keep
    end
  end

  def about
  end

  private

  def require_login
    fake_login if Rails.env.development?
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url
    end
  end

  def fake_login
    unless @current_user
      @current_user = User.first
      session[:user_id] = @current_user.id
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
