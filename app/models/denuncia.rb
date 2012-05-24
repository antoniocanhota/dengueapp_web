class Denuncia < ActiveRecord::Base
  
  ATIVA = "DNSA"
  REJEITADA = "DNSR"
  CANCELADA = "DNSC"
  RESOLVIDA = "DNSS"
  
  belongs_to :denunciante
  
  acts_as_gmappable :process_geocoding => false
  
  before_create :atribuir_valores_iniciais
  
  scope :ativas, where(:situacao => Denuncia::ATIVA)
  scope :rejeitadas, where(:situacao => Denuncia::REJEITADA)
  
  def gmaps4rails
    "#{self.latitude},#{self.longitude}"
  end
  
  def atribuir_valores_iniciais
    self.situacao = Denuncia::ATIVA if self.situacao.blank?
    self.data_e_hora = Time.now if self.data_e_hora.blank?
  end
  
  def rejeitar
    if self.situacao == Denuncia::ATIVA
      self.update_attribute(:situacao,Denuncia::REJEITADA)
    else
      errors[:base] << "Somente denúncias com situação ATIVA podem ser rejeitadas."
    end
  end
  
  def cancelar
    if self.situacao == Denuncia::ATIVA
      self.update_attribute(:situacao,Denuncia::CANCELADA)
    else
      errors[:base] << "Somente denúncias com situação ATIVA podem ser canceladas."
    end
  end
  
  def resolver
    if self.situacao == Denuncia::ATIVA
      self.update_attribute(:situacao,Denuncia::RESOLVIDA)
    else
      errors[:base] << "Somente denúncias com situação ATIVA podem ser resolvidas."
    end
  end
  
end
