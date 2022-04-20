# Husky Challenge


## Configuração

### Dependências de ambiente

- Ruby `>= 3.1.0`
  - bundler `>= 2.3.4`
  - rails `>= 7`
- Node.js `>= 16.13.2`
  - npm `>= 8.0`
  - yarn `>= 1.22.0`
- Postgresql 12

### Preparando ambiente de desenvolvimento

1) Instale as dependências de ambiente.
  - Instale o ruby `3.1.0` pelo seu gerenciador ruby
  - Instale o  bundler na versão 2.3.4 utilizando `gem install bundler -v 2.3.4`
  - Instale o nodejs na versão 16.13.2
  - Instale o npm na versão 8.1.2
  - Instale o yarn na versão 1.22.18
  - Instale o postgres na versão 12 ou faça como eu e utilize o docker
  ```sh
  docker run --name husky-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mypassword -d postgres:12
  ```
  - Instale as dependências do ruby usando `bundle install` ou apenas `bundle`
  - Instale as dependências de javascript usando `yarn install --frozen-lockfile` ou apenas `yarn --frozen-lockfile`

2) Crie o arquivo `config/master.key`.

```sh
echo '2500af7274898ae80b2c62be1bbbb64f' > config/master.key

chmod 600 config/master.key
```

3) Crie o aquivo `config/database.yml` a partir do `config/database.yml.sample`.

4) Configure o arquivo `config/database.yml`.

Caso você tenha usado o docker como sugeri sua configuração ficará assim:
```yml

default: &default
  adapter: postgresql
  encoding: unicode
  username: postgres
  password: mypassword
  host: localhost
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: husky_challenge_development

production:
  <<: *default
  database: husky_challenge_production
  username: husky_challenge
  password: <%= ENV["HUSKY_CHALLENGE_DATABASE_PASSWORD"] %>
```
5) Execute `bin/setup`

## Desenvolvimento

### Executando a aplicação

```sh
bin/dev
```

### Executando os testes

```sh
bin/rails spec
```
## O que foi feito?
---
### Web:
- Visitante:
  - Gerar token de acesso
  - Login via token
- Gerar token de acesso:
  - Geração de token com validação se é um email válido.
  - Geração de um novo token se o usuário já existe.
  - Envio da url "encriptada" pra link de ativação com Login

- Login via token:
  - Apresenta um campo de texto para o token e um botão para submeter o form e então acessar o sistema.
  - Validação se um token foi tornado inusável, não confirmado ou apenas inválido

- Usuário (fez login via token):
  - Deve ser posível listar invoices (pelo número da invoice e pelas data)
  - Visualizar invoice
  - Criar e enviar invoice
  - Logout

- Criar e enviar invoice:
  - Número da invoice (invoice_number)
  - Data (invoice_date)
  - Empresa (customer_notes e customer_name)
  - Valor total (total_amount_due)
  - Emails (emails)
  - Ao criar a invoice o usuário deve ser redirecionado para tela de visualização que apresentará os dados da invoice
  - Ao criar a invoice o usuário recebe um alerta informando que as invoices foram enviadas para os emails informados na criação

- Envio de invoices:
  - Corpo de email
    - Link para visualização
  - Anexo
    - Versão da invoice como pdf

- Visualização da invoice:
  - Deve apresentar todos os dados da invoice
  - Ação:
    - Deve ser posível fazer o download da invoice como pdf
    - Se logado:
      - O usuário poderá enviar a invoice para novos emails

---

### Api

- Deve ser possível listar as invoices por filtros como foi feito na web quando está usando o token de acesso nos headers
- Deve ser possível visualizar a invoice se você criou ela e está logado
- Deve ser possível criar e enviar invoice se você está logado
- Deve ser possível enviar invoices para novos emails se o usuário está logado

---
## Por que priorizei X em vez de Y?
 Priorizei o desenvolvimento de testes pois precisamos garantir que a aplicação funciona sem bugs.
 Priorizei segurança pois precisamos garantir que usuários distintos não possam mexer nas coisas de outro usuário.
 Priorizei manutenibilidade para simular uma aplicação real onde vários desenvolvedores teriam que realizar mudanças no código.
 Não priorizei performance por conta dos outros requisitos que no primeiro momento considero mais importantes eles do que esse (para essa aplicação ao menos).
 Não priorizei disponibilidade, confiabilidade e observabilidade por conta que para isso precisaria fazer o deploy no heroku, porém precisaria cadastrar uma conta na aws ou outro serviço de cloud para armazenar os pdfs gerados.

---

## Como foi feito? (Gems e Paradigmas)

Das gems mais importantes pro desenvolvimento de novas funcionalidades foram:
- [u-case](https://github.com/serradura/u-case) para criação de casos de uso numa forma padronizada
- [url-signature](https://github.com/fnando/url_signature) para criação de url "encriptada" para o link de email
- [modular_routes](https://github.com/vitoravelino/modular_routes) para criação de uma action por controller o que deixou os controllers mais limpos e mais manuteníveis.
- [prawn](https://github.com/prawnpdf/prawn) para geração de pdfs
  simples.
- [ransack](https://github.com/activerecord-hackery/ransack) para buscas
  sem precisar ter risco de sql injection
- [rswag](https://github.com/rswag/rswag) para geração de documentação de api utilizando a openapi e fazendo isso gerando testes (confesso que não gostei muito de gerar os testes usando ela por conta de muito `let` que eu tive que usar)
- [rspec-rails](https://github.com/rspec/rspec-rails) para criação e execução de testes automatizados
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
  para criação de factory ( basicamente serve para não precisar ficar fazendo
  `Model.create(attr1: x, attr2: y)` toda hora)
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) para criação de testes simples para models ( basicamente serve para não precisar ficar fazendo
```ruby
model = Model.new
expect(model.invalid?).to be true
```
)


Paradigmas utilizados:
- Utilizei Programação Orientada a Objetos com as classes criadas
- Utilizei Programação Funcional com lambdas e a utilização de casos de uso (de acordo com [essa talk](https://www.youtube.com/watch?v=w1OwYWe4UFo))
- Utilizei os design patterns:
  - Singleton (Controller)
  - Command (Controller e Models não pertencentes ao ActiveRecord)
  - Strategy (Models não pertencentes ao ActiveRecord pois todos usam a
    mesma interface)
  - Chain of Responsability (models que tem flow pois se uma parte falha
    os processos não continuam)

Softwares utilizados:
 - [Trello](https://trello.com) (para melhor estruturação de tarefas)
 - [RubyCi](https://ruby.ci) (o melhor CI para Ruby que você verá na sua vida, além de ser super rápido e garantir que todos os testes passem, que a padronização também passa e que o código está manutenível)
 - [Github](https://github.com) (para hospedagem do código, integração
   com o RubyCi e gerenciamento de pull requests)

---

## O que poderia ser melhorado?

1. Atualmente o PDF é gerado no próprio servidor podendo travar o mesmo,
   para não acontecer isso o pdf deve ser gerado usando background jobs
2. Corrigir N+1 query: Devido performance não ter sido priorizada devo
   ter deixado várias queries com N+1.
3. Fazer deploy no heroku para conseguir ver a aplicação funcionando e
   as pessoas usando.
4. Usar o appsignal para a identificação de problemas de performance e
   os erros que estão ocorrendo.
5. Melhorar a escrita dos testes: devido ao fato do rswag criar testes
   de um modo diferente a sentença arrange, act e assert foi
   comprometida nos testes gerados por este.
6. Adicionar turbo corretamente para melhor experiência do usuário:
   atualmente só adicionei para o logout.
7. Adicionar sidekiq ou resque como adapter dos background jobs: deixei
   o padrão que veio o async.
8. Deixar a aplicação mais responsiva: pelo foco não ser frontend desse
   teste não me preocupei tanto com a responsividade
9. Paginação: Todas as invoices pertencentes a determinados usuários
   estão vindo na página (o que é ruim para a performance), para isso eu
   adicionaria a gem pagy e paginaria os resultados
