#!/bin/env ruby
# encoding: utf-8

class DenunciasController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource

  def index
    @denuncias = Denuncia.accessible_by(current_ability,:manage)
    case params[:situacao]
      when Denuncia::ATIVA
        @denuncias = @denuncias.ativas
      when Denuncia::REJEITADA
        @denuncias = @denuncias.rejeitadas
      when Denuncia::CANCELADA
        @denuncias = @denuncias.canceladas
      when Denuncia::RESOLVIDA
        @denuncias = @denuncias.resolvidas
    end
    if params[:usuario_id]
      @denuncias = @denuncias.do_usuario(params[:usuario_id])
    end
    @denuncias = @denuncias.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => 'info_window', :locals => {:denuncia => denuncia})
    end
  end

  def update_situacao
    @denuncia = Denuncia.find(params[:denuncia_id])
    if ((params[:situacao] == Denuncia::ATIVA and current_ability.can? :ativar, @denuncia) or
        (params[:situacao] == Denuncia::REJEITADA and current_ability.can? :rejeitar, @denuncia) or
        (params[:situacao] == Denuncia::CANCELADA and current_ability.can? :cancelar, @denuncia) or
        (params[:situacao] == Denuncia::RESOLVIDA and current_ability.can? :resolver, @denuncia)
    )
      if @denuncia and @denuncia.update_attribute(:situacao,params[:situacao])
        msg_de_erro = ""
      else
        msg_de_erro = "Erro desconhecido ao atualizar a situação da denúncia ##{params[:denuncia_id]}."
      end
    else
      msg_de_erro = "Você não possui permissão para mudar a situação da denúncia ##{params[:denuncia_id]} para a situação desejada."
    end
    if msg_de_erro.empty?
      redirect_to :back#, :notice => "Situação da denúncia ##{params[:denuncia_id]} alterada com sucesso."
      flash.now[:notice] = "Situação da denúncia ##{params[:denuncia_id]} alterada com sucesso."
    else
      redirect_to :back, :error => msg_de_erro
    end
  end

  def estatisticas
    @denuncias_por_bairro = Denuncia.ativas.group(:bairro).count.to_a
    @denuncias_por_cidade = Denuncia.ativas.group(:cidade).count.to_a
    @denuncias_por_dia
  end

end
