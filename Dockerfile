FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y curl gnupg2 postgresql-client

# Instala Node.js 23.x
RUN curl -fsSL https://deb.nodesource.com/setup_23.x | bash -
RUN apt-get install -y nodejs

# Instala Yarn 1.x (Chatwoot ainda usa Yarn Classic)
RUN npm install --global yarn@1.22.19

WORKDIR /app

COPY . .

RUN gem install bundler && bundle install
RUN yarn install --check-files

# Precompilar os assets
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy DATABASE_URL=postgres://dummy@localhost/dummy bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
