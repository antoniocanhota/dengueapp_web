#encoding: utf-8
#language: pt
Funcionalidade: Rejeitar denúncias no sistema
    Para poder rejeitar uma denúncia no sistema
    Como um moderador
    Eu devo ter a opção de rejietar uma determinada denúncia ativa

Contexto:
    Dado que eu esteja logado como um moderador

@javascript
Cenário: Rejeitar uma denúncia ativa
    Dado que exista uma denúncia ativa
    E que eu esteja na página de detalhes da denúncia acima
    Quando eu clico em 'Rejeitar Denúncia'
    E eu aperto "Sim" no pop-up de confirmação
    Então eu devo ver 'Denúncia rejeitada com sucesso.'

Cenário: Não devo poder rejeitar uma denúncia rejeitada
    Dado que exista uma denúncia rejeitada
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Rejeitar Denúncia'

Cenário: Não devo poder rejeitar uma denúncia cancelada
    Dado que exista uma denúncia cancelada
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Rejeitar Denúncia'

Cenário: Não devo poder rejeitar uma denúncia resolvida
    Dado que exista uma denúncia resolvida
    E que eu esteja na página de detalhes da denúncia acima
    Então eu não devo ver 'Rejeitar Denúncia'