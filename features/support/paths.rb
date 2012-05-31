#encoding: UTF-8
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|  
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      
    when /^página inicial$/
      '/'
      
    when /^página inicial de administrador$/
      home_administrador_path
      
    when /^página inicial de moderador$/
      home_moderador_path
      
    when /^página inicial de denunciante$/
      home_denunciante_path
      
    when /^página de gerenciamento de denúncias$/
      ativas_denuncias_path
      
    when /^página de gerenciamento de denúncias ativas$/
      ativas_denuncias_path
      
    when /^página de gerenciamento de denúncias rejeitadas$/
      rejeitadas_denuncias_path
      
    when /^página de gerenciamento de denúncias canceladas$/
      canceladas_denuncias_path
      
    when /^página de gerenciamento de denúncias resolvidas$/
      resolvidas_denuncias_path
      
    when /página de detalhes da denúncia na coordenada "(.*)","(.*)"/
      denuncia_path(Denuncia.find_by_latitude_and_longitude($1,$2))
      
    when /página das minhas denúncias/
      minhas_denuncias_path
      
    when /^página de gerenciamento de operadores$/
      moderadores_operadores_path
      
    when /^página de cadastro de operador$/
      new_operador_path
      
    when /^página de detalhes do operador (.*)$/
      if $1 == "recém cadastrado" or $1 == "acima"
        operador_path(Operador.last)
      else
        operador_path($1)
      end
      
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
