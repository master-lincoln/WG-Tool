class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
  end
  
  def about
  end
  
  def standings
  	@users = User.all
  end
  
end
