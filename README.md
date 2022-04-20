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

