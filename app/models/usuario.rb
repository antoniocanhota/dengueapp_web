#!/bin/env ruby
# encoding: utf-8

class Usuario < ActiveRecord::Base
  
  SENHA_PADRAO = 'qwerty123'

  @dispositivo_primario = nil
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :rememberable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nome, :codigo_de_verificacao, :identificador_do_hardware, :numero_do_telefone
  attr_accessor :codigo_de_verificacao, :identificador_do_hardware, :numero_do_telefone
  
  has_one :denunciante
  has_one :operador
  
  validates_presence_of :nome
  validate :verificar_existencia_do_dispositivo, :on => :create
  validates_length_of :codigo_de_verificacao, :is => 6
  
  after_create :enviar_email_de_confirmacao_de_cadastro, :associar_dispositivo_primario_e_denunciante
  
  #TODO: refatorar para realocar parte desses métodos para a classe Operador
  def administrador?
    if self.operador
      return true if (self.operador.tipo == Operador::ADMINISTRADOR and self.operador.situacao == Operador::ATIVO)
    end
    return false
  end
  
  #TODO: refatorar para realocar parte desses métodos para a classe Operador
  def moderador?
    if self.operador
      return true if (self.operador.tipo == Operador::MODERADOR and self.operador.situacao == Operador::ATIVO)
    end
    return false
  end
  
  def denunciante?
    if self.denunciante
      return true if (self.denunciante.situacao == Denunciante::CADASTRADO)
    end
    return false
  end
  
  def enviar_email_de_confirmacao_de_cadastro
    DengueAppMailer.conta_criada(self).deliver
  end

  def associar_dispositivo_e_denunciante(dispositivo)
    dispositivo.denunciante.update_attribute(:usuario_id,self.id)
  end

  private

  def associar_dispositivo_primario_e_denunciante
    self.associar_dispositivo_e_denunciante(@dispositivo_primario)
  end

  def verificar_existencia_do_dispositivo
    if self.numero_do_telefone.blank? and self.identificador_do_hardware.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.usuario.numero_de_telefone_e_identificador_de_hardware_em_branco'))
    elsif self.codigo_de_verificacao.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.usuario.codigo_de_verificacao_em_branco'))
    else
      if !self.numero_do_telefone.blank?
        @dispositivo_primario = Dispositivo.find_all_by_numero_do_telefone_real(self.numero_do_telefone,self.codigo_de_verificacao).first
      elsif !self.identificador_do_hardware.blank?
        @dispositivo_primario = Dispositivo.find_all_by_identificador_do_hardware_real(self.identificador_do_hardware,self.codigo_de_verificacao).first
      end
      if @dispositivo_primario.nil?
        errors.add(:base, I18n.t('activerecord.errors.models.usuario.dispositivo_nao_encontrado'))
      end
    end
  end
  
end
