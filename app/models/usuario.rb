#!/bin/env ruby
# encoding: utf-8

class Usuario < ActiveRecord::Base
  
  SENHA_PADRAO = 'qwerty123'

  DENUNCIANTE_CADASTRADO = "UDSC"
  DENUNCIANTE_BANIDO = "UDSB"
  DENUNCIANTE_DESISTENTE = "UDSD"

  @dispositivo_primario = nil
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :rememberable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nome, :codigo_de_verificacao, :identificador_do_hardware, :numero_do_telefone
  attr_accessor :codigo_de_verificacao, :identificador_do_hardware, :numero_do_telefone
  
  has_many :dispositivos
  
  validates_presence_of :nome
  validate :definicao_de_perfil
  validate :verificar_existencia_do_dispositivo, :on => :create
  validates_length_of :codigo_de_verificacao, :is => 6
  
  after_create :enviar_email_de_confirmacao_de_cadastro, :associar_dispositivo_primario
  
  def denunciante?
    if (self.denunciante_situacao == DENUNCIANTE_CADASTRADO)
      return true
    else
      return false
    end
  end

  def banivel?
    if (self.denunciante?) and (self.denuncias.rejeitadas.count >= 3) and (self.denunciante_situacao == DENUNCIANTE_CADASTRADO)
      return true
    else
      return false
    end
  end

  def banir
    if self.banivel?
      ActiveRecord::Base.transaction do
        self.update_attribute(:denunciante_situacao,DENUNCIANTE_BANIDO)
        self.denuncias.ativas.each do |d|
          d.rejeitar
        end
      end
    else
      errors[:base] << "Somente usuários com situação CADASTRADO e pelo menos 3 denúncias rejeitadas podem ser banidos."
    end
  end

  def desistir
    if self.denunciante_situacao == DENUNCIANTE_CADASTRADO
      ActiveRecord::Base.transaction do
        self.update_attribute(:denunciante_situacao,DENUNCIANTE_CESISTENTE)
        self.denuncias.ativas.each do |d|
          d.cancelar
        end
      end
    else
      errors[:base] << "Somente usuários com situação CADASTRADO podem ser alterados para DESISTENTE."
    end
  end
  
  def enviar_email_de_confirmacao_de_cadastro
    DengueAppMailer.conta_criada(self).deliver
  end

  def associar_dispositivo(dispositivo)
    dispositivo.update_attribute(:usuario_id,self.id)
  end

  def denuncias
    Denuncia.joins(:dispositivos).where(:dispositivos => {:usuario_id => self.id})
  end

  private
  def definicao_de_perfil
    # code here
  end

  def associar_dispositivo_primario
    self.associar_dispositivo(@dispositivo_primario)
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
