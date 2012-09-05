Dado /^que exista um (.+)/ do |tipo_de_usuario|
  case tipo_de_usuario
  when /^administrador$/
    @usuario = @administrador = (FactoryGirl.create :administrador).usuario
  when /^moderador$/
    @usuario = @moderador = (FactoryGirl.create :moderador).usuario
  when /^administrador inativo$/
    @usuario = @administrador_inativo = (FactoryGirl.create :administrador_inativo).usuario
  when /^moderador inativo$/
    @usuario = @moderador_inativo = (FactoryGirl.create :moderador_inativo).usuario
  when /^moderador pré-cadastrado$/
    @usuario = @moderador_precadastrado = (FactoryGirl.create :moderador_precadastrado).usuario
  when /^denunciante$/
    @usuario = @denunciante = (FactoryGirl.create :denunciante_com_login).usuario
  when /^usuário qualquer$/
    @usuario = Factory.create :usuario
  end
end

#TODO: Refatorar para usr o sessoes.rb
Quando /^eu preencho meu e\-mail e senha de (.+)$/ do |tipo_de_usuario|
  case tipo_de_usuario
  when /^administrador$/
    fill_in('usuario_email', :with => @administrador.email)
  when /^moderador/
    fill_in('usuario_email', :with => @moderador.email)
  when /^denunciante/
    fill_in('usuario_email', :with => @denunciante.email)
  end
  fill_in('usuario_password', :with => 'qwerty123')
  click_button('Acessar')
end

Então /^eu devo ver o usuário (.+)/ do |tipo_de_usuario|
  case tipo_de_usuario
  when /^administrador$/
    dados_do_usuario = @administrador
  when /^moderador$/
    dados_do_usuario = @moderador
  when /^administrador inativo$/
    dados_do_usuario = @administrador_inativo
  when /^moderador inativo$/
    dados_do_usuario = @moderador_inativo
  when /^denunciante$/
    dados_do_usuario = @denunciante
  end
  step("eu devo ver '##{dados_do_usuario.id}'")
  step("eu devo ver '#{dados_do_usuario.nome}'")
  step("eu devo ver '#{dados_do_usuario.email}'")
end

Então /^eu não devo ver o usuário (.+)/ do |tipo_de_usuario|
  case tipo_de_usuario
  when /^administrador$/
    dados_do_usuario = @administrador
  when /^moderador$/
    dados_do_usuario = @moderador
  when /^administrador inativo$/
    dados_do_usuario = @administrador_inativo
  when /^moderador inativo$/
    dados_do_usuario = @moderador_inativo
  when /^denunciante$/
    dados_do_usuario = @denunciante
  end
  step("eu não devo ver '##{dados_do_usuario.id}'")
  step("eu não devo ver '#{dados_do_usuario.nome}'")
  step("eu não devo ver '#{dados_do_usuario.email}'")
end

Quando /^eu preencho os dados de um novo (.+) corretamente/ do |tipo_de_usuario|
  numero_aleatorio = rand(100).to_s
  case tipo_de_usuario
  when /^moderador$/
    choose('operador_tipo_uotm')
  end
  fill_in('operador_usuario_attributes_nome', :with => "C_USUARIO_#{numero_aleatorio}")
  fill_in('operador_usuario_attributes_email', :with => "c_usuario_#{numero_aleatorio}@mail.com")
end
Então /^eu devo ver os dados do operador (.+)$/ do |id|
  if id == "recém cadastrado"
    op = Operador.last
  else
    op = Operador.find(id)
  end
  step("eu devo ver '#{op.id}'")
  step("eu devo ver '#{op.usuario.nome}'")
  step("eu devo ver '#{op.usuario.email}'")
  #TODO: estudar uma maneira de codificar isso baseado no metodo do application_helper
  #step("eu devo ver '#{op.tipo}'")
  #step("eu devo ver '#{op.situacao}'")
end

Então /^o botão de (.+) operador não deve estar disponível$/ do |acao|
  case acao
  when "ativar"
    step("eu não devo ver 'Ativar Operador'")
  when "desativar"
    step("eu não devo ver 'Desativar Operador'")
  end
end

