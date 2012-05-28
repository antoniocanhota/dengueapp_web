class Usuario < ActiveRecord::Base
  
  SENHA_PADRAO = 'qwerty123'
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :rememberable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nome
  
  has_one :denunciante
  has_one :operador
  
  validates :nome, :presence => true
  
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
  
end
