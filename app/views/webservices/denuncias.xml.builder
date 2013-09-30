xml.instruct!
xml.denuncias do
  unless (@denuncias == nil or @denuncias.empty?)
    @denuncias.each do |d|
	    xml.denuncia do
	     xml.id d.id
	     xml.tag! 'data-e-hora', '30 de setembro de 2013, 00:00:01'
	     xml.latitude d.latitude
	     xml.longitude d.longitude
	     xml.url_imagem d.foto.url
       xml.situacao d.situacao
	    end
    end
  end
end