#!/bin/env ruby
# encoding: utf-8

class DispositivosController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource

  def index
    @dispositivos = Dispositivo.accessible_by(current_ability)
  end

  def vincular
    if params[:apelido].blank?
      redirect_to dispositivos_path, :alert => "Um apelido deve ser informado."
      return
    else
      dispositivo = Dispositivo.where(:codigo_de_ativacao => params[:codigo_de_ativacao]).first
      if (dispositivo == nil)
        redirect_to dispositivos_path, :alert => "Nenhum dispositivo foi encontrado com os dados informados."
        return
      end
      binding.pry
      if dispositivo and dispositivo.usuario_id.blank?
        dispositivo.apelido = params[:apelido]
        dispositivo.usuario_id = current_user.id
        if dispositivo.save
          redirect_to dispositivos_path, :notice => "Dispositivo vinculado com sucesso."
        else
          redirect_to dispositivo_path, :alert => "Erro ao vincular o dispositivo. Erro: #{dispositivo.errors.full_messages}"
        end
      else
        redirect_to dispositivos_path, :alert => "O dispositivo especificado já está vinculado a outro usuário."
      end
    end
  end

  def update
    @dispositivo = Dispositivo.find(params[:id])
    if @dispositivo.update_attributes(params[:dispositivo])
      redirect_to dispositivos_path, :notice => "Dispositivo atualizado com sucesso."
    else
      redirect_to dispositivos_path, :alert => "Erro ao atualizar dispositivo. #{@dispositivo.errors.full_messages}"
    end
  end

end
