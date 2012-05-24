#encoding: utf-8
#language: pt
Funcionalidade: Cadastro de operadores
    Para poder cadastrar um operador
    Como um administrador
    Eu devo habilitar um usuário para isso

Contexto:
    Dado que eu esteja logado como um administrador
    E que eu esteja na página de cadastro de operador

Cenário: Cadastrar um moderador corretamente
    Quando eu preencho os dados de um novo moderador corretamente
    E eu aperto 'Salvar'
    Então eu devo estar na página de detalhes do operador recém cadastrado
    E eu devo ver 'Operador cadastrado e/ou habilitado com sucesso.'
    E eu devo ver os dados do operador recém cadastrado

@wip
Cenário: Tentativa de cadastrar um moderador sem informar dado algum
    Quando eu aperto 'Salvar'
    Então eu devo ver 'Não foi possível cadastrar o operador. Corrija os erros abaixo:'

