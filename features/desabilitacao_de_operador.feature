#encoding: utf-8
#language: pt
Funcionalidade: Desativação de moderadores do sistema
    Para poder desabilitar um moderador do sistema
    Como um administrador
    Eu devo ter a opção de desabilitar o acesso do usuário como moderador

Contexto:
    Dado que eu esteja logado como um administrador

@javascript
Cenário: Desabilitar um moderador ativo a partir do gerenciamento de operadores
    Dado que exista um moderador
    E que eu esteja na página de detalhes do operador acima
    Quando eu clico em 'Desativar Operador'
    E eu aperto "Sim" no pop-up de confirmação
    Então eu devo ver 'Operador desativado com sucesso.'

@javascript
Cenário: Devo poder desabilitar um moderador pré-cadastrado
    Dado que exista um moderador pré-cadastrado
    E que eu esteja na página de detalhes do operador acima
    Quando eu clico em 'Desativar Operador'
    E eu aperto "Sim" no pop-up de confirmação
    Então eu devo ver 'Operador desativado com sucesso.'

Cenário: Não devo poder desabilitar um moderador inativo
    Dado que exista um moderador inativo
    E que eu esteja na página de detalhes do operador acima
    Então o botão de desativar operador não deve estar disponível