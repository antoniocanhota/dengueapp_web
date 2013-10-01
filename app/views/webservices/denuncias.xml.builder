xml.instruct!
xml.denuncias do
  unless (@denuncias == nil or @denuncias.empty?)
    @denuncias.each do |d|
	    xml.denuncia do
	     xml.id d.id
	     xml.tag! 'data-e-hora', I18n.l(d.data_e_hora)
	     xml.latitude d.latitude
	     xml.longitude d.longitude
	     xml.url_imagem d.foto.url
       xml.situacao d.situacao
	    end
    end
  end
end