#!/bin/env ruby
# encoding: utf-8
require 'digest'

class Dispositivo < ActiveRecord::Base

  CADASTRADO = "DISC"
  BANIDO = "DISB"

  has_many :denuncias  
  belongs_to :usuario

  before_create :gerar_codigo_de_ativacao

  validates :situacao,
              :inclusion => {:in => [CADASTRADO,BANIDO]}
  validate :banibilidade,
              :if => :banindo?

  def banir
    self.situacao = BANIDO
    self.denuncias.each do |d|
      d.situacao = Denuncia::REJEITADA if d.situacao == Denuncia::ATIVA
    end
    self.save
  end

  private
  
  def gerar_codigo_de_ativacao
    generated = false
    while (!generated)
      codigo_de_ativacao = 100000+Random.rand(899999)
      dispositivo = Dispositivo.where(:codigo_de_ativacao => codigo_de_ativacao).first
      if (dispositivo == nil)
        self.codigo_de_ativacao = codigo_de_ativacao
        generated = true
      end
    end
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
