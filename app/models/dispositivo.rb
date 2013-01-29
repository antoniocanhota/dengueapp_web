#!/bin/env ruby
# encoding: utf-8

class Dispositivo < ActiveRecord::Base
  
  has_many :denuncias  
  belongs_to :denunciante

  validates_presence_of :denunciante_id

  before_create :codificar_numero_de_telefone_e_identificador_do_hardware

  private
  
  def codificar_numero_de_telefone_e_identificador_do_hardware
    self[:identificador_do_hardware] = Digest::SHA1.hexdigest(self.identificador_do_hardware) if self.identificador_do_hardware
    self[:numero_do_telefone] = Digest::SHA1.hexdigest(self.numero_do_telefone) if self.numero_do_telefone
  end
  
end
