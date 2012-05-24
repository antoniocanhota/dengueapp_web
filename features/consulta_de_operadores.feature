#encoding: utf-8
#language: pt
Funcionalidade: Consulta de operadores do sistema
    Para poder consultar os operadores do sistema
    Como um administrador
    Eu devo ter acesso à listagem de operadores de detalhar seus dados

Contexto:
    Dado que eu esteja logado como um administrador
    E que exista um moderador

Cenário: Mostrar os moderadores, por padrão, em gerenciamento de operadores
    Dado que eu esteja na página de gerenciamento de operadores
    Então eu devo ver o moderador
    E eu não devo ver o administrador

Cenário: Listar moderadores ativos ou pré-cadastrados
    Dado que eu esteja na página de gerenciamento de operadores
    Quando eu clico em 'Moderadores'
    Então eu não devo ver o administrador
    E eu devo ver o moderador

Cenário: Listar administradores ativos ou pré-cadastrados
    Dado que eu esteja na página de gerenciamento de operadores
    Quando eu clico em 'Administradores'
    Então eu não devo ver o moderador
    E eu devo ver o administrador

Cenário: Listar moderadores inativos
    Dado que eu esteja na página de gerenciamento de operadores
    E que exista um moderador inativo
    Quando eu clico em 'Moderadores'
    E eu devo ver o moderador inativo

Cenário: Listar administradores inativos
    Dado que eu esteja na página de gerenciamento de operadores
    E que exista um administrador inativo
    Quando eu clico em 'Administradores'
    Então eu devo ver o administrador inativo
