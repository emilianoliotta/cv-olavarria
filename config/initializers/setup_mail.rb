ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port  => 587,
  :domain  => 'cv-olavarria.herokuapp.com',
  :user_name => "compra.venta.olav@gmail.com",
  :password => "Marmu-Liotta",
  :authentication => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "cv-olavarria.herokuapp.com"