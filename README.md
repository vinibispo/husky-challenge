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
