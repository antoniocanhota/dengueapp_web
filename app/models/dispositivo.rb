#!/bin/env ruby
# encoding: utf-8
require 'digest'

class Dispositivo < ActiveRecord::Base
  
  has_many :denuncias  
  belongs_to :usuario

  before_create :codificar_numero_de_telefone_e_identificador_do_hardware

  def self.find_all_by_numero_do_telefone_real(numero_do_telefone,codigo_de_verificacao)
    numero_do_telefone_codificado = Digest::SHA1.hexdigest((numero_do_telefone.to_i + codigo_de_verificacao.to_i).to_s)
    return Dispositivo.where(:numero_do_telefone => numero_do_telefone_codificado)
  end

  def self.find_all_by_identificador_do_hardware_real(identificador_do_hardware,codigo_de_verificacao)
    identificador_do_hardware_codificado = Digest::SHA1.hexdigest((identificador_do_hardware.to_i + codigo_de_verificacao.to_i).to_s)
    dispositivo = Dispositivo.where(:identificador_do_hardware => identificador_do_hardware_codificado)
  end

  private
  
  def codificar_numero_de_telefone_e_identificador_do_hardware
    self[:identificador_do_hardware] = Digest::SHA1.hexdigest(self.identificador_do_hardware) if self.identificador_do_hardware
    self[:numero_do_telefone] = Digest::SHA1.hexdigest(self.numero_do_telefone) if self.numero_do_telefone
  end
  
end
