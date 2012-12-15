#!/bin/env ruby
# encoding: utf-8

class PublicController < ApplicationController
  
  def index
    @denuncias = Denuncia.ativas.all.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => "/denuncias/info_window", :locals => {:denuncia => denuncia})
    end
    @denuncias_objeto = Denuncia.ativas
  end

  def login
    
  end
  
end
