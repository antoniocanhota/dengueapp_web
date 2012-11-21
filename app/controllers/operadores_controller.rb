#!/bin/env ruby
# encoding: utf-8

class OperadoresController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  
  def index
    redirect_to moderadores_operadores_path
  end
  
  def administradores
    @operadores = Operador.administradores_inclusive_inativos
    render 'index'
  end
  
  def moderadores
    @operadores = Operador.moderadores_inclusive_inativos
    render 'index'
  end

  def show
    @operador = Operador.find(params[:id])
  end

  def new
    @operador = Operador.new
    @operador.build_usuario
  end

  def create
    @operador = Operador.new(params[:operador])
    @operador.usuario.password_confirmation = @operador.usuario.password = Usuario::SENHA_PADRAO
    if @operador.save
      DengueAppMailer.notificar_alteracao_em_operador(@operador,"ativado").deliver
      redirect_to @operador, :notice => 'Operador cadastrado e/ou habilitado com sucesso.' 
    else
      render :action => "new"
    end
  end
  
  def desativar
    @operador = Operador.find(params[:id])
    if @operador.desativar
      DengueAppMailer.notificar_alteracao_em_operador(@operador,"desativado").deliver
      redirect_to @operador, :notice => 'Operador desativado com sucesso.'
    else
      redirect_to @operador, :error => 'Erro ao desativar o operador.'
    end
  end
  
  def ativar
    @operador = Operador.find(params[:id])
    if @operador.ativar
      DengueAppMailer.notificar_alteracao_em_operador(@operador,"ativado").deliver
      redirect_to @operador, :notice => 'Operador ativado com sucesso.'
    else
      redirect_to @operador, :error => 'Erro ao ativar o operador.'
    end
  end
  
  # GET /operadores/1/edit
  def edit
    @operador = Operador.find(params[:id])
  end

  # PUT /operadores/1
  # PUT /operadores/1.json
  def update
    @operador = Operador.find(params[:id])

    respond_to do |format|
      if @operador.update_attributes(params[:operador])
        format.html { redirect_to @operador, :notice => 'Operador was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @operador.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /operadores/1
  # DELETE /operadores/1.json
  def destroy
    @operador = Operador.find(params[:id])
    @operador.destroy

    respond_to do |format|
      format.html { redirect_to operadores_url }
      format.json { head :ok }
    end
  end
end
