class Denuncia < ActiveRecord::Base
  
  ATIVA = "DNSA"
  REJEITADA = "DNSR"
  CANCELADA = "DNSC"
  RESOLVIDA = "DNSS"
  
  belongs_to :dispositivo
  belongs_to :denunciante
  
  accepts_nested_attributes_for :denunciante
  accepts_nested_attributes_for :dispositivo
  
  acts_as_gmappable :process_geocoding => false
  
  before_create :atribuir_valores_iniciais
  
  scope :ativas, where(:situacao => Denuncia::ATIVA)
  scope :rejeitadas, where(:situacao => Denuncia::REJEITADA)
  scope :canceladas, where(:situacao => Denuncia::CANCELADA)
  scope :resolvidas, where(:situacao => Denuncia::RESOLVIDA)
  scope :do_denunciante, lambda{ |denunciante_id| where(:denunciante_id => denunciante_id) unless denunciante_id.blank? }
  
  def gmaps4rails
    "#{self.latitude},#{self.longitude}"
  end
  
  def atribuir_valores_iniciais
    self.situacao = Denuncia::ATIVA if self.situacao.blank?
    self.data_e_hora = Time.now if self.data_e_hora.blank?
  end
  
  def ativa?
    return true if self.situacao == Denuncia::ATIVA
  end
  
  def reativavel?
    return true if self.rejeitada?
  end
  
  def reativar
    if self.reativavel?
      self.update_attribute(:situacao,Denuncia::ATIVA)
    else
      errors[:base] << "Somente denúncias com situação REJEITADA, CANCELADA ou RESOLVIDA podem ser reativadas."
    end
  end
  
  def rejeitada?
    return true if self.situacao == Denuncia::REJEITADA
  end
  
  def rejeitavel?
    if self.situacao == Denuncia::ATIVA
      return true
    else
      return false
    end
  end
  
  def rejeitar
    if self.situacao == Denuncia::ATIVA
      self.update_attribute(:situacao,Denuncia::REJEITADA)
    else
      errors[:base] << "Somente denúncias com situação ATIVA podem ser rejeitadas."
    end
  end
  
  def cancelada?
    return true if self.situacao == Denuncia::CANCELADA
  end
  
  def cancelar
    if self.situacao == Denuncia::ATIVA
      self.update_attribute(:situacao,Denuncia::CANCELADA)
    else
      errors[:base] << "Somente denúncias com situação ATIVA podem ser canceladas."
    end
  end
  
  def resolvida?
    return true if self.situacao == Denuncia::RESOLVIDA
  end
  
  def resolver
    if self.situacao == Denuncia::ATIVA
      self.update_attribute(:situacao,Denuncia::RESOLVIDA)
    else
      errors[:base] << "Somente denúncias com situação ATIVA podem ser resolvidas."
    end
  end
  
end
