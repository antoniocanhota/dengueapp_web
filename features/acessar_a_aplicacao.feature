#encoding: utf-8
#language: pt
Funcionalidade: Acessar a aplicação
    Para poder acessar as ferramentas da aplicação
    Como um usuário qualquer
    Eu devo poder ver fazer login

Contexto:
    Dado que exista um administrador
    E que exista um moderador
    E que exista um denunciante
    E que eu esteja na página inicial

Cenário: Administrador acessando
    Quando eu preencho meu e-mail e senha de administrador
    Então eu devo estar na página inicial de administrador

Cenário: Moderador acessando
    Quando eu preencho meu e-mail e senha de moderador
    Então eu devo estar na página inicial de moderador

Cenário: Denunciante acessando
    Quando eu preencho meu e-mail e senha de denunciante
    Então eu devo estar na página inicial de denunciante

Cenário: Encerrar sessão
    Dado que eu esteja logado como um usuário qualquer
    Quando eu clico em 'Sair'
    Então eu devo estar na página inicial
    E eu devo ver 'Você fez logout com sucesso.'