#encoding: utf-8
#language: pt
Funcionalidade: Reativar denúncias no sistema
    Para não poder reativar uma denúncia no sistema
    Como um moderador
    Eu não devo ter a opção de reativar uma determinada denúncia rejeitada

Contexto:
    Dado que eu esteja logado como um moderador

@javascript
Cenário: Não devo poder reativar uma denúncia rejeitada
    Dado que exista uma denúncia rejeitada
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Reativar Denúncia'

Cenário: Não devo poder reativar uma denúncia ativa
    Dado que exista uma denúncia ativa
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Reativar Denúncia'

Cenário: Não devo poder reativar uma denúncia cancelada
    Dado que exista uma denúncia cancelada
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Reativar Denúncia'

Cenário: Não devo poder reativar uma denúncia resolvida
    Dado que exista uma denúncia resolvida
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Reativar Denúncia'