Então /^eu não devo poder acessar a (.+)$/ do |pagina|
  visit path_to(pagina)
  step "eu devo ver 'Sua conta de usuário não possui privilégios para esse tipo de operação.'"
end

