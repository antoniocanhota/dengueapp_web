# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Dengueapp::Application

Dengueapp::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[Erro Dengueapp]",
  :sender_address => %{"DengueApp (Exception Notification)" <dengueapp@gmail.com>} ,
  :exception_recipients => %w{antoniocanhota@gmail.com}
