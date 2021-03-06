#!/bin/env ruby
# encoding: utf-8

class Denuncia < ActiveRecord::Base
  
  ATIVA = "DNSA"
  REJEITADA = "DNSR"
  CANCELADA = "DNSC"
  RESOLVIDA = "DNSS"

  QTD_DENUNCIAS_REJEITADAS_PARA_BANIR_DENUNCIANTE = 3
  
  belongs_to :dispositivo
  has_attached_file :foto,
    :storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    :dropbox_options => {
      :path => proc { "foto_denuncia_#{Rails.env}_#{id}.jpg" }
    }
  accepts_nested_attributes_for :dispositivo
  
  acts_as_gmappable :process_geocoding => false

  before_save :identificar_bairro_e_cidade
  before_create :atribuir_valores_iniciais
  after_save :atualizar_banilidade_do_usuario_ou_dispositivo
  
  scope :ativas, where(:situacao => Denuncia::ATIVA)
  scope :rejeitadas, where(:situacao => Denuncia::REJEITADA)
  scope :canceladas, where(:situacao => Denuncia::CANCELADA)
  scope :resolvidas, where(:situacao => Denuncia::RESOLVIDA)
  scope :do_denunciante, lambda{ |denunciante_id| where(:denunciante_id => denunciante_id) unless denunciante_id.blank? }

  def self.do_usuario(usuario_id)
    Denuncia.joins(:dispositivo).where(:dispositivos => {:usuario_id => usuario_id})
  end

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

  private

  def identificar_bairro_e_cidade
    if (self.new_record? or self.changes.include? "latitude" or self.changes.include? "longitude")
      endereco_geocodificado = Gmaps4rails.geocode("#{self.latitude},#{self.longitude}").first
      endereco_geocodificado[:full_data]["address_components"].each do |c|
        self.bairro = c["long_name"] if c["types"].include? "sublocality"
        self.cidade = c["long_name"] if c["types"].include? "locality"
      end
    end
  end

  def atualizar_banilidade_do_usuario_ou_dispositivo
    if self.changes.include? "situacao" and self.situacao == REJEITADA
      if self.dispositivo.usuario_id
        qtd_denuncias_rejeitadas = Denuncia.do_usuario(self.dispositivo.usuario_id).where(:situacao => REJEITADA).count
        if qtd_denuncias_rejeitadas >= QTD_DENUNCIAS_REJEITADAS_PARA_BANIR_DENUNCIANTE
          self.dispositivo.usuario.update_attribute(:banivel,true)
        end
      else
        qtd_denuncias_rejeitadas = self.dispositivo.denuncias.where(:situacao => REJEITADA).count
        if qtd_denuncias_rejeitadas >= QTD_DENUNCIAS_REJEITADAS_PARA_BANIR_DENUNCIANTE
          self.dispositivo.update_attribute(:banivel,true)
        end
      end
    end
  end

end
