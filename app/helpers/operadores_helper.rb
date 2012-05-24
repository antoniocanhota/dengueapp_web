module OperadoresHelper
  
  def exibir_situacao(situacao)
    case situacao
    when Operador::PRECADASTRADO
      "PRÉ-CADASTRADO"
    when Operador::ATIVO
      "ATIVO"
    when Operador::INATIVO
      "INATIVO"
    else
      "DESCONHECIDA"
    end
  end
  
end
