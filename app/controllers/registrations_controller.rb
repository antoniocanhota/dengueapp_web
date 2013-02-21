#!/bin/env ruby
# encoding: utf-8

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def cancelar_conta
    usuario = Usuario.find(params[:usuario_id])
    if usuario.cancelar_denunciante
      set_flash_message :notice, "Conta desativada com sucesso"
      sign_out_and_redirect(root_path)
    else
      redirect_to :back, :alert => "Erro ao cancelar conta: #{usuario.errors.full_messages}"
    end
  end

end