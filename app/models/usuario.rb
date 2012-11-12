class Usuario < ActiveRecord::Base
  
  SENHA_PADRAO = 'qwerty123'
  
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
  
  after_create :enviar_email_de_confirmacao_de_cadastro
  
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
  
  private
    
  def verificar_existencia_do_dispositivo
    if self.numero_do_telefone.blank? and self.identificador_do_hardware.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.usuario.numero_de_telefone_e_identificador_de_hardware_em_branco'))
    elsif !self.codigo_de_verificacao.blank?
      if !self.numero_do_telefone.blank?
        dispositivo = Dispositivo.where(:numero_do_telefone => self.numero_do_telefone, :codigo_de_verificacao => self.codigo_de_verificacao).first
      elsif !self.identificador_do_hardware.blank?
        dispositivo = Dispositivo.where(:identificador_do_hardware => self.identificador_do_hardware, :codigo_de_verificacao => self.codigo_de_verificacao).first
      end
      if dispositivo
        dispositivo.denunciante.usuario = self
      else
        errors.add(:base, I18n.t('activerecord.errors.models.usuario.dispositivo_nao_encontrado'))
      end
    end
    
    
  end
  
end
