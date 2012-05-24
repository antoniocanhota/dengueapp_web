class DengueAppMailer < ActionMailer::Base
  #default :from => "antoniocanhota@gmail.com"
  
  def registration_confirmation(user)
    @usuario = user
    mail(:to => user.email, :subject => "Sua conta no DengueApp foi criada!", :from => "antoniocanhota@gmail.com")
  end
end
