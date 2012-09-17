class WebservicesController < ApplicationController
  
  def denuncias
    render :xml => Denuncia.ativas, :except => [:created_at, :updated_at, :situacao, :denunciante_id]
  end
  
  def publicar_denuncia
    @denuncia = Denuncia.new(params[:denuncia])

    respond_to do |format|
      if @denuncia.save        
        format.xml { render :xml => @denuncia.to_xml, :status => :created, :location => @denuncia }
      else        
        format.xml { render :xml => @denuncia.errors.to_xml, :status => :unprocessable_entity }
      end
    end
  end
  
end