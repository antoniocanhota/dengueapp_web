class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :usuario_atual, :current_user
  
  def usuario_atual
    current_usuario
  end
  
  def current_user
    usuario_atual
  end
  
  rescue_from CanCan::AccessDenied do
    redirect_to acesso_negado_path
  end
  
  def acesso_negado
    render 'layouts/denied'
  end
  
end
