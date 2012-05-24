#encoding: utf-8
#language: pt
Funcionalidade: Restrção de acesso às prinicipais funcionalidades
    Para poder garantir a seguraça do sistema
    Como um visitante
    Eu não devo ter acesso limitada às funcionalidades do sistema

Contexto:
    Dado que eu esteja na página inicial

Cenário: Funcionalidade de gerenciamento de denúncias
    Então eu não devo ver 'Gerenciar Denúncias'
    E eu devo ser obrigado a logar
 
Cenário: Funcionalidade de gerenciamento de operadores
    Então eu não devo ver 'Gerenciar Operadores'
    E eu devo ser obrigado a logar

Cenário: Funcionalidade de gerenciamento das minhas denúncias (sem ser denunciante)
    Então eu não devo ver 'Minhas Denúncias'
    E eu devo ser obrigado a logar

Cenário: Funcionalidade de visualização pública de denúnicas (sem ser denunciante)
    Então eu não devo ver 'Todas as Denúncias'
