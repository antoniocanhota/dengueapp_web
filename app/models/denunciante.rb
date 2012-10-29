class Denunciante < ActiveRecord::Base

  CADASTRADO = "UDSC"
  BANIDO = "UDSB"
  DESISTENTE = "UDSD"
  
  belongs_to :usuario
  has_many :denuncias
  has_many :dispositivos
  
  accepts_nested_attributes_for :usuario
  
  before_create :atribuir_valores_iniciais
  
  def atribuir_valores_iniciais
    self.situacao = Denunciante::CADASTRADO if self.situacao.blank?
  end
  
  def banivel?
    if (self.denuncias.rejeitadas.count >= 3) and (self.situacao == Denunciante::CADASTRADO)
      return true
    else
      return false
    end
  end
  
  def banir
    if self.banivel?
      #TODO: Colocar num transaction a alteração de status do usuários e suas denuncias ativas
      self.update_attribute(:situacao,Denunciante::BANIDO)
      self.denuncias.ativas.each do |d|
        d.rejeitar
      end
    else
      errors[:base] << "Somente usuários com situação CADASTRADO e pelo menos 3 denúncias rejeitadas podem ser banidos."
    end
  end
  
  def desistir
    if self.situacao == Denunciante::CADASTRADO
      #TODO: Colocar num transaction a alteração de status do usuários e suas denuncias ativas
      self.update_attribute(:situacao,Denunciante::DESISTENTE)
      self.denuncias.ativas.each do |d|
        d.cancelar
      end
    else
      errors[:base] << "Somente usuários com situação CADASTRADO podem ser alterados para DESISTENTE."
    end
  end
  
end
