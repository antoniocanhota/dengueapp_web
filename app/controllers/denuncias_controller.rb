#!/bin/env ruby
# encoding: utf-8

class DenunciasController < ApplicationController
  
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  
  def ativas
    @denuncias = Denuncia.ativas.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => 'info_window', :locals => {:denuncia => denuncia})  
    end
    render 'index'
  end
  
  def rejeitadas
    @denuncias = Denuncia.rejeitadas.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => 'info_window', :locals => {:denuncia => denuncia})  
    end
    render 'index'
  end
  
  def canceladas
    @denuncias = Denuncia.canceladas.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => 'info_window', :locals => {:denuncia => denuncia})  
    end
    render 'index'
  end
  
  def resolvidas
    @denuncias = Denuncia.resolvidas.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => 'info_window', :locals => {:denuncia => denuncia})  
    end
    render 'index'
  end
  
  def index
    redirect_to ativas_denuncias_path
  end

  def minhas_denuncias
    minhas_denuncias = usuario_atual.denuncias
    @minhas_denuncias = minhas_denuncias.all.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => "/denuncias/info_window", :locals => {:denuncia => denuncia})
    end
    @minhas_denuncias_objeto = minhas_denuncias
  end
  
  def show
    @denuncia = Denuncia.find(params[:id])
    @marcador =  @denuncia.to_gmaps4rails do |denuncia,marker|
      marker.infowindow render_to_string(:partial => 'info_window', :locals => {:denuncia => denuncia})  
    end
  end

  # GET /denuncias/new
  # GET /denuncias/new.json
  def new
    @denuncia = Denuncia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @denuncia }
    end
  end

  # GET /denuncias/1/edit
  def edit
    @denuncia = Denuncia.find(params[:id])
  end

  def reativar
    @denuncia = Denuncia.find(params[:id])
    if @denuncia.reativar
      redirect_to @denuncia, :notice => 'Denúncia reativada com sucesso.'
    else
      redirect_to @denuncia, :error => '"Erro ao reativar a denúncia.'
    end
  end
  
  def rejeitar
    @denuncia = Denuncia.find(params[:id])
    if @denuncia.rejeitar
      redirect_to @denuncia, :notice => 'Denúncia rejeitada com sucesso.'
    else
      redirect_to @denuncia, :error => '"Erro ao rejeitar a denúncia.'
    end
  end
  
  # POST /denuncias
  # POST /denuncias.json
  def create
    @denuncia = Denuncia.new(params[:denuncia])

    respond_to do |format|
      if @denuncia.save
        format.html { redirect_to @denuncia, :notice => 'Denuncia was successfully created.' }
        format.json { render :json => @denuncia, :status => :created, :location => @denuncia }
      else
        format.html { render :action => "new" }
        format.json { render :json => @denuncia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /denuncias/1
  # PUT /denuncias/1.json
  def update
    @denuncia = Denuncia.find(params[:id])

    respond_to do |format|
      if @denuncia.update_attributes(params[:denuncia])
        format.html { redirect_to @denuncia, :notice => 'Denuncia was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @denuncia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /denuncias/1
  # DELETE /denuncias/1.json
  def destroy
    @denuncia = Denuncia.find(params[:id])
    @denuncia.destroy

    respond_to do |format|
      format.html { redirect_to denuncias_url }
      format.json { head :ok }
    end
  end
  
end
