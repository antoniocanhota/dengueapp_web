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
  
end
