#encoding: utf-8
#language: pt
Funcionalidade: Consulta de denúncias no sistema
    Para poder consultar as denúnicas registradas no sistema
    Como um moderador
    Eu devo ter acesso ao mapa de denúnicias, classificando-as por tipo

Contexto:
    Dado que eu esteja logado como um moderador
    E que eu esteja na página de gerenciamento de denúncias

Cenário: Listar as denúncias ativas, por padrão, em gerenciamento de denúncias

Cenário: Listar denúncias ativas
    Quando eu clico em 'Ativas'
    Então eu devo estar na página de gerenciamento de denúncias ativas

Cenário: Listar denúnicas rejeitadas
    Quando eu clico em 'Rejeitadas'
    Então eu devo estar na página de gerenciamento de denúncias rejeitadas

Cenário: Listar denúnicas canceladas
    Quando eu clico em 'Canceladas'
    Então eu devo estar na página de gerenciamento de denúncias canceladas

Cenário: Listar denúncias resolvidas
    Quando eu clico em 'Resolvidas'
    Então eu devo estar na página de gerenciamento de denúncias resolvidas
