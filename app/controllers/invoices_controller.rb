class InvoicesController < ApplicationController
  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.order('created_at DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @invoice = Invoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.json
  def create
    user_ids = params[:invoice][:userids].split(',')
    params[:invoice].delete :userids
    params[:invoice][:price] = params[:invoice][:price].gsub(/\,/, "." )
    @invoice = Invoice.new(params[:invoice])

    if user_ids.empty?
      flash[:error] = "Please enter asscociated users"
      render action: "new"
      return
    end
    @invoice.creator = current_user

    respond_to do |format|
      if @invoice.save
        # create duties
        user_ids.each do |user_id|
          user = User.find(user_id)
          Duty.create!(:invoice => @invoice, :user => user)
        end
        mail_errors = send_mails(:created)
        if mail_errors
          flash[:error] = "Error while sending mail notifications: contact admin"
        end
        format.html { redirect_to @invoice, :flash => { success: 'Invoice was successfully created.' } }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])
    if current_user != @invoice.creator
      redirect_to :root, :error => "Du darfst nur deine eigenen Rechnungen bearbeiten."
      return
    end

    user_ids = params[:invoice][:userids].split(',').collect { |id_str| id_str.to_i}
    params[:invoice].delete :userids
    params[:invoice][:price] = params[:invoice][:price].gsub(/\,/, "." )

    if user_ids.empty?
      render action: "edit", notice: 'No users given'
      return
    end

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        # find duties to remove
        to_remove = Duty.where(:invoice_id => @invoice.id).all.reject { |duty| user_ids.include? duty.user_id }
        Duty.delete(to_remove.collect { |r| r.id })
        # find or add remaining
        user_ids.each do |user_id|
          duty = Duty.find_or_create_by_invoice_id_and_user_id(@invoice.id, user_id)
        end
        mail_errors = send_mails(:updated)
        if mail_errors
          flash[:error] = "Error while sending mail notifications: contact admin"
        end
        format.html { redirect_to @invoice, :flash => { success: 'Invoice was successfully updated.'} }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :ok }
    end
  end


  private
  def send_mails(type)
    errors = false
    @invoice.users.each do |user|
      if user.wants_mail && user.email != ''
        begin
          case type
          when :created
            UserMailer.invoice_created(user, @invoice).deliver
          when :updated
            UserMailer.invoice_updated(user, @invoice).deliver
        end
        rescue Exception
          puts $!, $@
          errors |= true
        end
      end
    end
    return errors
  end

end
