#encoding: utf-8
#language: pt
Funcionalidade: Reativação de moderadores do sistema
    Para poder reativar um moderador do sistema
    Como um administrador
    Eu devo ter a opção de reativar o acesso do usuário como moderador

Contexto:
    Dado que eu esteja logado como um administrador

@javascript
Cenário: Reativar um moderador inativo a partir do gerenciamento de operadores
    Dado que exista um moderador inativo
    E que eu esteja na página de detalhes do operador acima
    Quando eu clico em 'Ativar Operador'
    E eu aperto "Sim" no pop-up de confirmação
    Então eu devo ver 'Operador ativado com sucesso.'

Cenário: Não devo poder ativar um moderador pré-cadastrado
    Dado que exista um moderador pré-cadastrado
    E que eu esteja na página de detalhes do operador acima
    Então o botão de ativar operador não deve estar disponível

Cenário: Não devo poder ativar um moderador inativo
    Dado que exista um moderador ativo
    E que eu esteja na página de detalhes do operador acima
    Então o botão de ativar operador não deve estar disponível    