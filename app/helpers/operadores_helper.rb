#!/bin/env ruby
# encoding: utf-8

module OperadoresHelper

  def badge_de_tipo_ou_situacao(tipo_operador_codificado)
    case tipo_operador_codificado
      when Usuario::MODERADOR
        texto = "Moderador"
        cor_do_badge = "info"
      when Usuario::ADMINISTRADOR
        texto = "Administrador"
        cor_do_badge = "inverse"
      when Usuario::OPERADOR_INATIVO
        texto = "Operador Inativo"
        cor_do_badge = "default"
    end
    "<span class='badge badge-#{cor_do_badge}'>#{texto}</span>".html_safe
  end

end
