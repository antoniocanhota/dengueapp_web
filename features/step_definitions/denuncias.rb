Dado /^que exista uma denúncia(| )(ativa|rejeitada|cancelada|resolvida|)( na coordenada '(.+)')?$/ do |ignorar_1,situacao,ignorar_2,coordenada|
  if coordenada.nil?
    lat = -22.9048188493015
    lon = -43.13112258911133
  else
    lat = coordenada.split(',').first.to_f
    lon = coordenada.split(',').second.to_f
  end
  case situacao
  when /^rejeitada$/
    Factory.create :denuncia_rejeitada, :latitude => lat, :longitude => lon
  when /^cancelada$/
    Factory.create :denuncia_cancelada, :latitude => lat, :longitude => lon
  when /^resolvida$/
    Factory.create :denuncia_resolvida, :latitude => lat, :longitude => lon
  else
    Factory.create :denuncia, :latitude => lat, :longitude => lon
  end
end

Então /^eu devo ver o número identificador da denúncia$/ do
  step("eu devo ver '##{Denuncia.last.id}'")
end

Então /^eu devo ver a data em que a denúncia foi feita$/ do
  step("eu devo ver '#{I18n.l Denuncia.last.data_e_hora}'")
end

Então /^eu devo ver a situação da denúncia$/ do
  situacao_codificada = Denuncia.last.situacao
  case situacao_codificada
  when Denuncia::ATIVA
    step("eu devo ver 'Ativa'")
  when Denuncia::CANCELADA
    step("eu devo ver 'Cancelada'")
  when Denuncia::REJEITADA
    step("eu devo ver 'Rejeitada'")
  when Denuncia::RESOLVIDA
    step("eu devo ver 'Resolvida'")
  end
end