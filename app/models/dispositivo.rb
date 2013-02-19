#!/bin/env ruby
# encoding: utf-8
require 'digest'

class Dispositivo < ActiveRecord::Base

  CADASTRADO = "DISC"
  BANIDO = "DISB"

  has_many :denuncias  
  belongs_to :usuario

  before_create :codificar_numero_de_telefone_e_identificador_do_hardware

  validates :situacao,
              :inclusion => {:in => [CADASTRADO,BANIDO]}
  validate :banibilidade,
              :if => :banindo?

  def self.find_all_by_numero_do_telefone_real(numero_do_telefone,codigo_de_verificacao)
    numero_do_telefone_codificado = Digest::SHA1.hexdigest((numero_do_telefone.to_i + codigo_de_verificacao.to_i).to_s)
    return Dispositivo.where(:numero_do_telefone => numero_do_telefone_codificado)
  end

  def self.find_all_by_identificador_do_hardware_real(identificador_do_hardware,codigo_de_verificacao)
    identificador_do_hardware_codificado = Digest::SHA1.hexdigest((identificador_do_hardware.to_i + codigo_de_verificacao.to_i).to_s)
    dispositivo = Dispositivo.where(:identificador_do_hardware => identificador_do_hardware_codificado)
  end

  def banir
    self.situacao = BANIDO
    self.denuncias.each do |d|
      d.situacao = Denuncia::REJEITADA if d.situacao == Denuncia::ATIVA
    end
    self.save
  end

  private
  
  def codificar_numero_de_telefone_e_identificador_do_hardware
    self[:identificador_do_hardware] = Digest::SHA1.hexdigest(self.identificador_do_hardware) if self.identificador_do_hardware
    self[:numero_do_telefone] = Digest::SHA1.hexdigest(self.numero_do_telefone) if self.numero_do_telefone
  end

  def banindo?
    return (self.changes.include? "situacao" and self.situacao == BANIDO)
  end

  def banibilidade
    unless (self.denuncias.rejeitadas.count >= Denuncia::QTD_DENUNCIAS_REJEITADAS_PARA_BANIR_DENUNCIANTE) or (self.usuario and self.usuario.denunciante_situacao == Usuario::DENUNCIANTE_BANIDO)
      errors.add(:situacao, I18n.t('activerecord.errors.models.dispositivo.attributes.situacao.nao_banivel'))
    end
  end

end
