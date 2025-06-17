FROM ruby:3.4.4

# Instala dependências básicas
RUN apt-get update -qq && apt-get install -y curl gnupg2 postgresql-client build-essential libvips

# Instala Node.js 18.x e Yarn 1.x (compatível com Chatwoot e Vite Rails)
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install --global yarn@1.22.19

WORKDIR /app

COPY . .

# Instala Gems
RUN gem install bundler && bundle install

# Evitar erros com Husky
RUN HUSKY_SKIP_INSTALL=1 yarn install --check-files

# Build Vite (parte crítica que estava quebrando antes)
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy DATABASE_URL=postgres://dummy@localhost/dummy bundle exec rake vite:build_all

# Precompile Rails assets
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy DATABASE_URL=postgres://dummy@localhost/dummy bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
