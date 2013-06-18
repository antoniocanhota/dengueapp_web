#!/bin/env ruby
# encoding: utf-8

module PublicHelper
  VERSAO_ANDROID = "20"
  VERSAO_ANDROID_HUMANO = "2.0"
  DATA_ULTIMA_VERSAO_ANDROID = "18/06/2013"

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
