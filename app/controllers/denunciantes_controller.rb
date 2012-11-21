#!/bin/env ruby
# encoding: utf-8

class DenunciantesController < ActionController::Base
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  
  def validar
    puts "oi"
  end
  
end