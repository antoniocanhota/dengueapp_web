#!/bin/env ruby
# encoding: utf-8

class OperadoresController < ApplicationController
  before_filter :authenticate_usuario!
  authorize_resource :class => false
  
  def index
    @operadores = Usuario.operadores
  end

  def new
    @operador = Usuario.new
  end

  def create
    @operador = Usuario.new(params[:usuario])
    @operador.password_confirmation = @operador.password = Usuario::SENHA_PADRAO
    if @operador.save
      DengueAppMailer.notificar_alteracao_em_operador(@operador,"ativado").deliver
      redirect_to @operador, :notice => "Operador ##{@operador.id} cadastrado  com sucesso."
    else
      render :action => "new"
    end
  end

  def edit
    @operador = Usuario.find(params[:id])
  end

  def update
    @operador = Usuario.find(params[:id])
      if @operador.update_attributes(params[:usuario])
        redirect_to operadores_path, :notice => "Dados do operador ##{@operador.id} alterados com sucesso."
      else
        render :action => "edit"
      end

  end

end
