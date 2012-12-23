xml.instruct!
xml.denuncias do
  unless @denuncias.empty?
    xml.denuncia do
     xml.id @denuncias[0]['id']
     xml.tag! 'data-e-hora', I18n.l(@denuncias[0]['data_e_hora']) 
     xml.latitude @denuncias[0]['latitude']
     xml.longitude @denuncias[0]['longitude']
     xml.url_imagem @denuncias[0].foto.url
    end
  end
end