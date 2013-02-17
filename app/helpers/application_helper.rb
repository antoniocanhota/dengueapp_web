#!/bin/env ruby
# encoding: utf-8

module ApplicationHelper
  
  def exibir_dado(rotulo,dado)
    if dado.class.name == "Time"
      dado = (I18n.l dado)
    end
    "<dt>#{rotulo}</dt><dd>#{dado}<dd>".html_safe
  end
  
  def is_active?(path)
    "active" if current_page?(path)
  end
  
  def exibir_primeiro_nome(nome)
    if nome
      nome.split.first.capitalize
    else
      "usuário"
    end
  end
  
end
