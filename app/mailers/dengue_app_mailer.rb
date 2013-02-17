class DengueAppMailer < ActionMailer::Base
  
  add_template_helper(ApplicationHelper)
  
  default :from => "dengueapp@gmail.com"
  
#  def registration_confirmation(user)
#    @usuario = user
#    mail(:to => user.email, :subject => "Sua conta no DengueApp foi criada!")
#  end
  
  def conta_criada(usuario)
    @usuario = usuario
    mail(:to => usuario.email, :subject => "Sua conta no DengueApp foi criada")
  end

  def notificar_alteracao_em_operador(usuario,acao_no_participio)
    @usuario = usuario
    @acao_no_participio = acao_no_participio.downcase
    mail(:to => @usuario.email, :subject => "Seu perfil de operador no DengueApp foi #{@acao_no_participio}")
  end
  
end
