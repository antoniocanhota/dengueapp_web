#encoding: utf-8
#language: pt
Funcionalidade: Ativar denúncias no sistema
    Para poder ativar uma denúncia no sistema
    Como um administrador
    Eu devo ter a opção de reativar uma determinada denúncia rejeitada

Contexto:
    Dado que eu esteja logado como um administrador

@javascript
Cenário: Reativar uma denúncia rejeitada
    Dado que exista uma denúncia rejeitada
    E que eu esteja na página de detalhes da denúncia acima
    Quando eu clico em 'Reativar Denúncia'
    E eu aperto "Sim" no pop-up de confirmação
    Então eu devo ver 'Denúncia reativada com sucesso.'

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