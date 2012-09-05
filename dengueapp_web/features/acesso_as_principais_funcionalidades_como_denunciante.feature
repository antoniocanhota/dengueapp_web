#encoding: utf-8
#language: pt
Funcionalidade: Acesso às prinicipais funcionalidades
    Para poder gerenciar minha conta e denúncias
    Como um denuncinate
    Eu devo ter acesso às minhas funcionalidades

Contexto:
    Dado que eu esteja logado como um denunciante
    E que eu esteja na página inicial de denunciante

Cenário: Funcionalidade de gerenciamento de denúncias (sem ser administrador e/ou moderador)
    Então eu não devo ver 'Gerenciar Denúnicas'
    E eu não devo poder acessar a página de gerenciamento de denúncias
 
Cenário: Funcionalidade de gerenciamento de operadores (sem ser administrador)
    Então eu não devo ver 'Gerenciar Operadores'
    E eu não devo poder acessar a página de gerenciamento de operadores

Cenário: Funcionalidade de cadastro de moderador (sem ser administrador)
    Dado que eu esteja na página de gerenciamento de operadores
    Então eu não devo ver 'Cadastrar Operador'

Cenário: Funcionalidade de gerenciamento das minhas denúncias
    Quando eu clico em 'Minhas Denúncias'
    Então eu devo estar na página das minhas denúncias

Cenário: Funcionalidade de visualização pública de denúnicas
    Quando eu clico em 'Todas as Denúncias'
    Então eu devo estar na página inicial de denunciante
