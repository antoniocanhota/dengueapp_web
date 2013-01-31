#!/bin/env ruby
# encoding: utf-8

module PublicHelper
  VERSAO_ANDROID = "11rc"
  VERSAO_ANDROID_HUMANO = "1.1rc"
  DATA_ULTIMA_VERSAO_ANDROID = "30/01/2013"

  def resoruce_name
    :usuario
  end
  
  def resource
    @resource || Usuario.new
  end
  
  def devise_mapping
    @devise_mapping  ||= Devise.mappings[:usuario]
  end
  
end
