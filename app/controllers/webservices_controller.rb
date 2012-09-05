class WebservicesController < ApplicationController
  
  def denuncias
    render :xml => Denuncia.ativas, :except => [:created_at, :updated_at, :situacao, :denunciante_id]
  end
end