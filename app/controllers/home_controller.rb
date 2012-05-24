class HomeController < ApplicationController
  before_filter :authenticate_usuario!
  authorize_resource :class => false
  
  def index
    if usuario_atual.administrador?
      redirect_to home_administrador_path
    elsif usuario_atual.moderador?
      redirect_to home_moderador_path
    elsif usuario_atual.denunciante?
      redirect_to home_denunciante_path
    end        
  end
  
  def administrador
  end

  def moderador
  end

end
