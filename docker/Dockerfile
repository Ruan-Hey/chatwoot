FROM ruby:3.4.4

# Variáveis de ambiente
ENV NODE_ENV=production
ENV RAILS_ENV=production

# Dependências básicas
RUN apt-get update -qq && apt-get install -y curl gnupg2 postgresql-client build-essential

# Node.js 23.x
RUN curl -fsSL https://deb.nodesource.com/setup_23.x | bash - && apt-get install -y nodejs

# Yarn Classic (1.x)
RUN npm install -g yarn@1.22.19

# pnpm (obrigatório para Chatwoot 4.x)
RUN npm install -g pnpm@10.2.0

WORKDIR /app

# Copia o código
COPY . .

# Instala as gems
RUN gem install bundler && bundle install

# Instala dependências JS com pnpm
RUN pnpm install --frozen-lockfile

# Faz o build manual do Vite antes dos assets Rails
RUN bundle exec rake vite:build_all

# Agora sim: Precompile Rails assets
RUN SECRET_KEY_BASE=dummy DATABASE_URL=postgres://dummy@localhost/dummy bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
