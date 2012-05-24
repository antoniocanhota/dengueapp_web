Dado /^que exista uma denúncia (.+) na coordenada "([^"]*)","([^"]*)"/ do |situacao,lat,lon|
  case situacao
  when /^ativa$/
    Factory.create :denuncia, :latitude => lat, :longitude => lon
  when /^rejeitada$/
    Factory.create :denuncia_rejeitada, :latitude => lat, :longitude => lon
  when /^cancelada$/
    Factory.create :denuncia_cancelada, :latitude => lat, :longitude => lon
  when /^resolvida$/
    Factory.create :denuncia_resolvida, :latitude => lat, :longitude => lon
  end
end

Então /^eu devo ver os detalhes (.+) da denúncia "([^"]*)","([^"]*)"$/ do |visibilidade,lat,lon|
#  denuncia = Denuncia.find_by_latitude_and_longitude(lat,lon)
#  case visibilidade
#  when /^públicos/
#    step("eu devo ver ")
#  end
end
