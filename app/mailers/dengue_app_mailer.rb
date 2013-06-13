#!/bin/env ruby
# encoding: utf-8

class DengueAppMailer < ActionMailer::Base
  
  add_template_helper(ApplicationHelper)
  
  default :from => "dengueapp@gmail.com"
  
#  def registration_confirmation(user)
#    @usuario = user
#    mail(:to => user.email, :subject => "Sua conta no DengueApp foi criada!")
#  end
  
  def conta_criada(usuario)
    @usuario = usuario
    mail(:to => usuario.email, :subject => "Sua conta no DengueApp foi criada")
  end

  def notificar_alteracao_em_operador(usuario,acao_no_participio)
    @usuario = usuario
    @acao_no_participio = acao_no_participio.downcase
    mail(:to => @usuario.email, :subject => "Seu perfil de operador no DengueApp foi #{@acao_no_participio}")
  end

  def reportar_excecao_da_aplicacao_movel(params)
    usuario = Usuario.new();
    usuario.nome = "Desenvolvedor"
    usuario.email = "antoniocanhota@id.uff.br"
    @usuario = usuario
    @exception = params[:exception]
    @trace = params[:trace]
    @android_version = params[:android_version]
    @android_id = params[:android_id]
    dispositivo = Dispositivo.where(:identificador_do_android => params[:android_id]).first;
    @dispositivo_encontrado = "Não"
    @usuario_encontrado = "Não"
    if dispositivo
      @dispositivo_encontrado = "Sim - ID [#{dispositivo.id}]"
      if dispositivo.usuario
        @usuario_encontrado = "Sim - ID [#{dispositivo.usuario.id}]"
      end
    end
    @manufacturer = params[:manufacturer]
    @model = params[:model]
    mail(:to => usuario.email, :subject => "[DengueApp Dev] Ocorreu um erro na aplicação móvel")
  end
  
end
