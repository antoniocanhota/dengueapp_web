#encoding: utf-8
#language: pt
Funcionalidade: Cadastro de usuário denunciante
    Para poder criar uma conta de usuário
    Como um denunciamte
    Eu devo poder informar um e-mail, telefone e senha válidos

Contexto:
    Dado que eu esteja na página inicial

@wip @javascript
Cenário: Criar uma conta de usuário para um denunciante existente
    Quando eu clico em 'Acompanhar Minhas Denúncias'
    Então eu devo estar na página de login
    Quando eu clico em 'Não Possuo Conta de Usuário'
    Então eu devo estar na página de criação de conta de usuário
    Quando eu preencho os campos necessários para a criação de uma nova conta de denunciante
    E eu aperto 'Salvar'
    Então mostre-me a página
    Então eu devo estar na página de validação do denunciante do usuário acima
    Quando eu preencho o código corretamente
    E eu aperto 'Salvar'
    Então eu devo estar na página inicial do denunciante
