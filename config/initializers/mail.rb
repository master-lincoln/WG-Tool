ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.googlemail.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'w9.t00l@googlemail.com',
  :password       => ENV['GMAIL_PASS'],
  :domain         => 'googlemail.com',
  :enable_starttls_auto => true
}
ActionMailer::Base.delivery_method = :smtp