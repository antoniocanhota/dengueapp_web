Então /^eu devo estar na (.+)$/ do |pagina_desejada|
  pagina_real = URI.parse(current_url).path
  if pagina_real.respond_to? :should
    pagina_real.should == path_to(pagina_desejada)
  else
    assert_equal path_to(pagina_desejada), pagina_real
  end
end

Dado /^que eu esteja na (.+)$/ do |pagina|
  visit path_to(pagina)
end

Quando /^eu clico em '([^"]*)'$/ do |link|
  click_link(link)
end

Quando /^eu aperto '([^"]*)'$/ do |botao|
  click_button(botao)
end

Então /^eu devo ver '([^"]*)'$/ do |mensagem|
  if page.respond_to? :should
    page.should have_content(mensagem)
  else
    assert page.has_content?(mensagem)
  end
end

Então /^eu não devo ver '([^"]*)'$/ do |texto|
  if page.respond_to? :should
    page.should have_no_content(texto)
  else
    assert page.has_no_content?(texto)
  end
end

Então /^mostre-me a página$/ do
  save_and_open_page
end

Quando /^eu aperto "Sim" no pop-up de confirmação$/ do
  page.driver.browser.switch_to.alert.accept    
end

Quando /^eu aperto "Cancelar" no pop-up de confirmação$/ do
  page.driver.browser.switch_to.alert.dismiss
end

