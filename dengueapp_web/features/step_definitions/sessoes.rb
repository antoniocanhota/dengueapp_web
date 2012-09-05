Dado /^que eu esteja logado como um (.+)$/ do |tipo_de_usuario|
  step "que exista um #{tipo_de_usuario}"
  step "que eu esteja na página inicial"
  fill_in('usuario_email', :with => @usuario.email)
  fill_in('usuario_password', :with => 'qwerty123')
  click_button "Acessar"
end

#TODO: Rever esse método para ele aceitar a mensagem e remover a gambiarra do botão "Acessar"
Então /^eu devo ser obrigado a logar$/ do
  #step 'eu devo ver "Para continuar, faça login ou registre-se."'
  step 'eu devo estar na página inicial'
  click_button "Acessar"
end
