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

  def download

  end

  def download_android
    send_file "public/android_app/dengueapp_android_#{PublicHelper::VERSAO_ANDROID}.apk", :type => " application/vnd.android.package-archive", :x_sendfile=>true
  end

  def conheca_a_aplicacao

  end

end
