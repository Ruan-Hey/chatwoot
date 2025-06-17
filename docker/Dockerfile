FROM ruby:3.4.4

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y curl gnupg2 postgresql-client build-essential libpq-dev

# Instalar Node.js 23.x
RUN curl -fsSL https://deb.nodesource.com/setup_23.x | bash - \
  && apt-get install -y nodejs

# Instalar Yarn 1.x
RUN npm install --global yarn@1.22.19

# Criar diretório de trabalho
WORKDIR /app

# Copiar código fonte
COPY . .

# Instalar gems
RUN gem install bundler && bundle install

# Instalar dependências Node
RUN yarn install --check-files

# Build do frontend Vite separado
RUN RAILS_ENV=production bundle exec rake vite:build_all

# Precompile de assets Rails
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy DATABASE_URL=postgres://dummy@localhost/dummy bundle exec rake assets:precompile

# Expor porta
EXPOSE 3000

# Comando default
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
