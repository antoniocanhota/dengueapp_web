module DenunciantesHelper

  def badge_de_situacao_de_dispositivo(situacao_codificada)
    case situacao_codificada
      when Dispositivo::CADASTRADO
        texto = "Cadastrado"
        cor_do_badge = "info"
      when Dispositivo::BANIDO
        texto = "Banido"
        cor_do_badge = "important"
      else
        texto = "Desconhecido"
        cor_do_badge = "default"
    end
    "<span class='badge badge-#{cor_do_badge}'>#{texto}</span>".html_safe
  end

  def badge_de_situacao_de_usuario(situacao_codificada)
    case situacao_codificada
      when Usuario::DENUNCIANTE_CADASTRADO
        texto = "Cadastrado"
        cor_do_badge = "info"
      when Usuario::DENUNCIANTE_BANIDO
        texto = "Banido"
        cor_do_badge = "important"
      when Usuario::DENUNCIANTE_DESISTENTE
        texto = "Desistente"
        cor_do_badge = "default"
      else
        texto = "Desconhecido"
        cor_do_badge = "default"
    end
    "<span class='badge badge-#{cor_do_badge}'>#{texto}</span>".html_safe
  end

end
