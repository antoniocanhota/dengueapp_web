#!/bin/env ruby
# encoding: utf-8

class Operador < ActiveRecord::Base
  
  MODERADOR = "UOTM"
  ADMINISTRADOR = "UOTA"
  
  ATIVO = "UOSA"
  INATIVO = "UOSI"
  PRECADASTRADO = "UOSP"
  
  belongs_to :usuario

  validates :usuario_id, :uniqueness => true
  
  accepts_nested_attributes_for :usuario
  
  before_create :atribuir_valores_iniciais
  before_validation :verificar_existencia_do_usuario, :on => :create
    
  scope :administradores, where("tipo = '#{Operador::ADMINISTRADOR}' and (situacao = '#{Operador::ATIVO}' or situacao = '#{Operador::PRECADASTRADO}')")
  scope :administradores_inclusive_inativos, where("tipo = '#{Operador::ADMINISTRADOR}' and (situacao = '#{Operador::ATIVO}' or situacao = '#{Operador::PRECADASTRADO}' or situacao = '#{Operador::INATIVO}')")
  scope :administradores_inativos, where("tipo = '#{Operador::ADMINISTRADOR}' and situacao = '#{Operador::INATIVO}'")
  scope :moderadores, where("tipo = '#{Operador::MODERADOR}' and (situacao = '#{Operador::ATIVO}' or situacao = '#{Operador::PRECADASTRADO}')")
  scope :moderadores_inclusive_inativos, where("tipo = '#{Operador::MODERADOR}' and (situacao = '#{Operador::ATIVO}' or situacao = '#{Operador::PRECADASTRADO}' or situacao = '#{Operador::INATIVO}')")
  scope :moderadores_inativos, where("tipo = '#{Operador::MODERADOR}' and situacao = '#{Operador::INATIVO}'")
  
  def atribuir_valores_iniciais
    self.situacao = Operador::ATIVO if self.situacao.blank?
  end
  
  def verificar_existencia_do_usuario
    usuario_existente = Usuario.find_by_email(self.usuario.email)
    if usuario_existente
      usuario_existente.nome = self.usuario.nome
      self.usuario = usuario_existente
    end
  end
  
  def moderador?
    return true if self.tipo == Operador::MODERADOR
  end
  
  def ativo?
    return true if self.situacao == Operador::ATIVO
  end
  
  def inativo?
    return true if self.situacao == Operador::INATIVO
  end
  
  def precadastrado?
    return true if self.situacao == Operador::PRECADASTRADO
  end
  
  def desativavel?
    if self.moderador? and (self.ativo? or self.precadastrado?)
      return true
    else
      return false
    end
  end
  
  def desativar
    if self.desativavel?
      self.update_attribute(:situacao,Operador::INATIVO)
      return true
    else
      return false
    end
  end
  
  def ativavel?
    if self.moderador? and self.inativo?
      return true
    else
      return false
    end
  end
  
  def ativar
    if self.ativavel?
      self.update_attribute(:situacao,Operador::ATIVO)
      return true
    else
      return false
    end
  end

end
