#encoding: utf-8
#language: pt
Funcionalidade: Acesso às prinicipais funcionalidades
    Para poder gerenciar o sistema
    Como um moderador
    Eu devo ter acesso às minhas funcionalidades

Contexto:
    Dado que eu esteja logado como um moderador
    E que eu esteja na página inicial de moderador

Cenário: Funcionalidade de gerenciamento de denúncias
    Quando eu clico em 'Gerenciar Denúncias'
    Então eu devo estar na página de gerenciamento de denúncias
 
Cenário: Funcionalidade de gerenciamento de operadores
    Então eu não devo ver 'Gerenciar Operadores'
    E eu não devo poder acessar a página de gerenciamento de operadores

Cenário: Funcionalidade de cadastro de moderador (sem ser administrador)
    Dado que eu esteja na página de gerenciamento de operadores
    Então eu não devo ver 'Cadastrar Operador'

Cenário: Funcionalidade de gerenciamento das minhas denúncias (sem ser denunciante)
    E eu não devo ver 'Minhas Denúncias'
    E eu não devo poder acessar a página das minhas denúncias

Cenário: Funcionalidade de visualização pública de denúnicas (sem ser denunciante)
    E eu não devo ver 'Todas as Denúncias'
