#!/bin/env ruby
# encoding: utf-8

class WebservicesController < ApplicationController
  
  def denuncias
    #render :xml => Denuncia.ativas, :except => [:created_at, :updated_at, :situacao, :denunciante_id, :dispositivo_id]
    if params[:identificador_do_android]
      dispositivo = Dispositivo.find_by_identificador_do_android(params[:identificador_do_android])
      if dispositivo and dispositivo.usuario
        @denuncia = Denuncia.do_usuario(dispositivo.usuario_id)
      elsif dispositivo
        @denuncias = dispositivo.denuncias
      else
        @denuncias = []
      end
    else
      @denuncias = Denuncia.ativas
    end
     respond_to do |format|
      format.xml#  { render :xml => Denuncia.ativas }
    end
  end
  
  def publicar_denuncia
    @denuncia = Denuncia.new(params[:denuncia])
    #Início da montagem da denúncia
    dispositivo = Dispositivo.find_by_identificador_do_android(params[:dispositivo][:identificador_do_android])
    if dispositivo
      @denuncia.dispositivo = dispositivo
    else
      dispositivo = @denuncia.build_dispositivo(params[:dispositivo])
      dispositivo.situacao = Dispositivo::CADASTRADO
    end
    #Fim da montagem da denúncia
    respond_to do |format|
      if @denuncia.save        
        format.xml { render :xml => @denuncia.to_xml, :status => :created, :location => @denuncia }
      else        
        format.xml { render :xml => @denuncia.errors.to_xml, :status => :unprocessable_entity }
      end
    end
  end
  
  def registro_do_dispositivo
    dispositivo = Dispositivo.find_by_identificador_do_android(params[:identificador_do_android])
    render :xml => dispositivo, :only => [:codigo_de_verificacao, :identificador_do_hardware, :numero_do_telefone]
  end
  
end