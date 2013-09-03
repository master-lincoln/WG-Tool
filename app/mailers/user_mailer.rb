class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper) 
  default from: "w9.t00l@googlemail.com"

  def invoice_created(user, invoice)
  	@user = user
  	@invoice = invoice
	mail :to => user.email, :subject => "Neue Rechnung von #{@invoice.creator.name}"
  end

  def invoice_updated(user, invoice)
  	@user = user
  	@invoice = invoice
	mail :to => user.email, :subject => "Rechnung veraendert von #{@invoice.creator.name}"
  end

end
