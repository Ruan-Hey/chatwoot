# Etapa de build
FROM ruby:3.3 AS rails-build

# Instala dependências básicas
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm postgresql-client curl git

# Instala Node 18.x e Yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs
RUN npm install --global yarn@1.22.19

WORKDIR /app
COPY . .

# Instala gems
RUN gem install bundler && bundle config set --local without 'development test' && bundle install -j4

# Instala pacotes JS
RUN yarn install --check-files

# Precompila assets
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=dummy
ENV DATABASE_URL=postgres://dummy@localhost/dummy
RUN bundle exec rake assets:precompile

# Etapa final (produção)
FROM ruby:3.3

RUN apt-get update -qq && apt-get install -y libpq-dev postgresql-client curl git nodejs npm

WORKDIR /app
COPY --from=rails-build /app /app

RUN gem install bundler && bundle config set --local without 'development test' && bundle install -j4

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
