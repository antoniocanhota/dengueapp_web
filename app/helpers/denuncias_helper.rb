#!/bin/env ruby
# encoding: utf-8

module DenunciasHelper
  
  def mapa_do_grande_rio(marcadores)
    gmaps("map_options" => {
        :center_latitude => "-22.890209",
        :center_longitude => "-43.296562", 
        :type => "HYBRID", 
        :zoom => 11,
        :auto_adjust => false
      },
      :markers => {"data" => marcadores}
    )
  end 
  
  def mapa_pontual(marcadores)
    gmaps("map_options" => {
        :type => "HYBRID", 
        :zoom => 11, 
      },
      :markers => {"data" => marcadores}
    )
  end

  def badge_de_situacao(situacao_codificada)
    case situacao_codificada
      when Denuncia::ATIVA
        texto_da_situacao = "Ativa"
        cor_do_badge = "info"
      when Denuncia::REJEITADA
        texto_da_situacao = "Rejeitada"
        cor_do_badge = "important"
      when Denuncia::CANCELADA
        texto_da_situacao = "Cancelada"
        cor_do_badge = "inverse"
      when Denuncia::RESOLVIDA
        texto_da_situacao = "Resolvida"
        cor_do_badge = "success"
    end
    "<span class='badge badge-#{cor_do_badge}' style='float: right;'>#{texto_da_situacao}</span>".html_safe
  end
  
end
