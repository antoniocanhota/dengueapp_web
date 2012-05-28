module ApplicationHelper
  
  def is_active?(path)
    "active" if current_page?(path)
  end
  
  def exibir_primeiro_nome(nome)
    if nome
      nome.split.first.capitalize
    else
      "usuário"
    end
  end
  
  def decodificar(constante)
    case constante
    when Operador::ADMINISTRADOR
      "Administrador"
    when Operador::MODERADOR
      "Moderador"
    when Operador::PRECADASTRADO
      "Pré-cadastrado"
    when Operador::ATIVO
      "Ativo"
    when Operador::INATIVO
      "Inativo"
    when Denuncia::ATIVA
      "Ativa"
    when Denuncia::REJEITADA
      "Rejeitada"
    when Denuncia::CANCELADA
      "Cancelada"
    when Denuncia::RESOLVIDA
      "Resolvida"
    when Denunciante::CADASTRADO
      "Cadastrado"
    when Denunciante::BANIDO
      "Banido"
    when Denunciante::DESISTENTE
      "Desistente"
    else
      "Desconhecido(a)"
    end
  end
  
end
