class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :require_login
  skip_before_filter :require_login, :only => [:home, :about]
  http_basic_authenticate_with :name => "wg", :password => ENV['HTTP_PASS'], :except => [:feed]

  def home
    if current_user
      redirect_to user_path(current_user)
    else
      flash.keep
    end
  end

  def about
  end

  def stats
    @numUsers = User.all.count
    @numInvoices = Invoice.all.count
    @users = User.all.map do |u|
      their_invoices = Invoice.where(:creator_id => u.id)
      {
        :name => u.name, 
        :invoice_count => their_invoices.count,
        :invoice_sum => their_invoices.sum(:price),
        :history => get_history_for(u.id)
      }
    end
  end

  private

  def get_history_for(user_id)
    results = Invoice.where(:creator_id => user_id).group("DATE_TRUNC('month', created_at)").count
    sums = Invoice.where(:creator_id => user_id).group("DATE_TRUNC('month', created_at)").sum(:price)
    results.map { |k,v| [Date.parse(k).to_time.to_i*1000, v, sums[k].to_s] }
  end

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
