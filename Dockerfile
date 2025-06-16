FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y curl gnupg2 postgresql-client

RUN curl -fsSL https://deb.nodesource.com/setup_23.x | bash - \
  && apt-get install -y nodejs \
  && npm install --global yarn@1.22.19

WORKDIR /app

COPY . .

RUN gem install bundler && bundle install
RUN yarn install --check-files

# Ajuste temporário: evita erro por falta de env
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy DATABASE_URL=postgres://dummy@localhost/dummy bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
