class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:feed]

  def search
    @users = User.where('lower(name) LIKE ?', "#{params[:q].downcase}%")

    respond_to do |format|
      format.html { render json: @users, :only => [:id, :name] }
      format.json { render json: @users, :only => [:id, :name] }
    end
  end

  def mail_info
    @user = User.find(params[:id])
    @user.email = params[:email]
    @user.wants_mail = params[:wants_mail] ? true : false;
    @user.save
    redirect_to @user, :notice => 'E-Mail Daten gespeichert.'
  end

  def feed
    @user = User.find(params[:id])
    @title = "W9Tool"
    @invoices = @user.mentioned_invoices
    @updated = @invoices.first.updated_at
    respond_to do |format|
      format.atom { render :layout => false }
      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @invoices = @user.mentioned_invoices
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
