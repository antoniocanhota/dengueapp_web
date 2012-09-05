#encoding: utf-8
#language: pt
Funcionalidade: Detalhar uma denúncia qualquer
    Para poder detalhar uma denúncia qualquer no sistema
    Como um administrador
    Eu devo ter uma tela para consultar as informações da denúncia

Contexto:
    Dado que eu esteja logado como um administrador
    E que exista uma denúncia ativa na coordenada '-22.5,-44.5'
    E que eu esteja na página de detalhes da denúncia na coordenada "-22.5","-44.5"

Cenário: Visualizar detalhes da denúncia
    Então eu devo ver o número identificador da denúncia
    E eu devo ver a data em que a denúncia foi feita
    E eu devo ver a situação da denúncia
    