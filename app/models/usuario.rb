#!/bin/env ruby
# encoding: utf-8

class Usuario < ActiveRecord::Base
  
  SENHA_PADRAO = 'qwerty123'

  DENUNCIANTE_CADASTRADO = "UDSC"
  DENUNCIANTE_BANIDO = "UDSB"
  DENUNCIANTE_DESISTENTE = "UDSD"

  MODERADOR = 5
  ADMINISTRADOR = 8
  OPERADOR_INATIVO = 0

  @dispositivo_primario = nil
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :rememberable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nome, :identificador_do_hardware, :numero_do_telefone, :tipo_operador, :denunciante_situacao
  attr_accessor :codigo_de_verificacao, :identificador_do_hardware, :numero_do_telefone
  
  has_many :dispositivos
  
  validates :nome,
              :presence => true,
              :unless => :denunciante?
  validates :tipo_operador,
              :inclusion => {:in => [MODERADOR, ADMINISTRADOR,OPERADOR_INATIVO]},
              :allow_blank => true
  validates :denunciante_situacao,
              :inclusion => {:in => [DENUNCIANTE_BANIDO, DENUNCIANTE_CADASTRADO, DENUNCIANTE_DESISTENTE]},
              :allow_blank => true
  validate :definicao_de_perfil
  validate :verificar_existencia_do_dispositivo,
              :on => :create,
              :if => :denunciante?
  validate :codigo_de_verificacao,
              :length => {:in => 1..6},
              :on => :create,
              :if => :denunciante?
  validate :banibilidade,
           :if => :banindo?
  
  after_create :enviar_email_de_confirmacao_de_cadastro

  after_create :associar_dispositivo_primario,
                :if => :denunciante?

  after_save :enviar_email_de_alteracao_de_tipo_de_operador,
                :if => :operador?

  scope :operadores, where("tipo_operador IN (?) ",[MODERADOR,ADMINISTRADOR,OPERADOR_INATIVO])
  scope :moderadores, where(:tipo_operador => MODERADOR)
  scope :administradores, where(:tipo_operador => ADMINISTRADOR)
  scope :operadores_inativos, where(:tipo_operador => OPERADOR_INATIVO)

  def moderador?
    return (self.tipo_operador == Usuario::MODERADOR)
  end

  def administrador?
    return (self.tipo_operador == Usuario::ADMINISTRADOR)
  end

  def operador?
    return ([MODERADOR,ADMINISTRADOR,OPERADOR_INATIVO].include? self.tipo_operador)
  end

  def denunciante?
    if (self.denunciante_situacao == DENUNCIANTE_CADASTRADO)
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

  def enviar_email_de_alteracao_de_tipo_de_operador
    DengueAppMailer.notificar_alteracao_em_operador(self,"alterado").deliver
  end

  def associar_dispositivo(dispositivo)
    dispositivo.update_attribute(:usuario_id,self.id)
  end

  def denuncias
    Denuncia.joins(:dispositivo).where(:dispositivos => {:usuario_id => self.id})
  end

  private
  def definicao_de_perfil
    if self.denunciante_situacao.blank? and self.tipo_operador.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.usuario.tipo_de_usuario_nao_definido'))
    end
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

  def banindo?
    return (self.changes.include? "denunciante_situacao" and self.situacao == BANIDO)
  end

  def banibilidade
    denuncias_do_usuario = Denuncia.do_usuario(self.id)
    unless (!denuncias_do_usuario.empty? and denuncias_do_usuario.rejeitadas.count >= Denuncia::QTD_DENUNCIAS_REJEITADAS_PARA_BANIR_DENUNCIANTE)
      errors.add(:denunciante_situacao, I18n.t('activerecord.errors.models.usuarios.attributes.denunciante_situacao.nao_banivel'))
    end
  end
  
end
