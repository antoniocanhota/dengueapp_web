module UsuariosHelper
  
  def exibir_primeiro_nome(nome)
    if nome
      nome.split.first.capitalize
    else
      "usuário"
    end
  end
  
end
