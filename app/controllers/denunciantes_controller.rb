#!/bin/env ruby
# encoding: utf-8

class DenunciantesController < ApplicationController
  before_filter :authenticate_usuario!
  authorize_resource :class => false

  def index
    @denunciantes = Dispositivo.all(:include => :usuario)
    if !params[:usuario_id].blank?
      @denunciantes = @denunciantes.where(:usuario_id => params[:usuario_id])
    end
    if !params[:dispositivo_id].blank?
      @denunciantes = @denunciantes.where(:id => params[:dispositivo_id])
    end
    if params[:apenas_baniveis] == "true"
      denunciantes_temp = @denunciantes
      @denunciantes = []
      denunciantes_temp.each do |d|
        @denunciantes << d if (d.banivel? or (d.usuario and d.banivel?))
      end
    end
  end

  def banir

  end

end
