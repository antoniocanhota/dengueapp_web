#encoding: utf-8
#language: pt
Funcionalidade: Acesso às prinicipais funcionalidades
    Para poder gerenciar o sistema
    Como um administrador
    Eu devo ter acesso às minhas funcionalidades

Contexto:
    Dado que eu esteja logado como um administrador
    E que eu esteja na página inicial de administrador

Cenário: Funcionalidade de gerenciamento de denúncias
    Quando eu clico em 'Gerenciar Denúncias'
    Então eu devo estar na página de gerenciamento de denúncias
 
Cenário: Funcionalidade de gerenciamento de operadores
    Quando eu clico em 'Gerenciar Operadores'
    Então eu devo estar na página de gerenciamento de operadores

Cenário: Funcionalidade de cadastro de moderador
    Dado que eu esteja na página de gerenciamento de operadores
    Quando eu clico em 'Cadastrar Operador'
    Então eu devo estar na página de cadastro de operador

Cenário: Funcionalidade de gerenciamento das minhas denúncias (sem ser denunciante)
    Então eu não devo ver 'Minhas Denúncias'

Cenário: Funcionalidade de visualização pública de denúnicas (sem ser denunciante)
    Então eu não devo ver 'Todas as Denúncias'

