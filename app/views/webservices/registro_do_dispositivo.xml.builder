xml.instruct!
xml.registro_do_dispositivo do
  xml.identificador_do_android @dispositivo.try(:identificador_do_android)
  xml.codigo_de_ativacao @dispositivo.try(:codigo_de_ativacao)
  xml.usuario_associado @dispositivo.try(:usuario).try(:email)
end