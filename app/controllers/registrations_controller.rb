#!/bin/env ruby
# encoding: utf-8

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    validar_denunciante_path(@usuario.denunciante.id)
  end
  
end