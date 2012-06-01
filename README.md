# DengueApp

## Sobre a aplicação

Esta aplicação faz parte de um trabalho de conclusão do curso de Ciência da Computação pela Universidade Federal Fluminense.

## Guia Rápido

É aconselhável um breve conhecimento sobre o framework Ruby on Rails antes de prosseguir. Também é recomendável utilizar o RVM - mais informações em <https://rvm.io//>.

Certifique-se de que já possiu o MySQL instalado em seu computador.

Após baixar o código fonte, dentro do diretório da aplicação, execute os seguintes comandos:

* rake db:create (cria o schema no banco de dados)
* rake db:migrate (cria as tabelas)
* rake db:seed (faz a carga mínima de dados)

Com isso, sua aplicação estará pronta para ser executada. Para inicalizar o servidor, execute o comando abaixo:

* rails s

A aplicação ficará disponível em <http://localhost:3000/>

## Problemas Comuns

Caso tenha problemas ao instalar o MySQL no OSX, veja <http://www.alishabdar.com/2011/03/22/running-mysql-5-5-and-rails-3-on-mac-os-x/>.

No Ubuntu, algumas dependências em relação ao MySQL também precisam ser resolvidas. Execute o comando abaixo caso haja algum problema com falta de bibliotecas.

* sudo apt-get install libmysql-ruby libmysqlclient-dev


