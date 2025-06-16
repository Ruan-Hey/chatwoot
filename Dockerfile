FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y curl gnupg2 postgresql-client

# Instalar Node.js e Yarn (versão 1.x)
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn@1.22.19

WORKDIR /app

COPY . .

RUN gem install bundler && bundle install
RUN yarn install --check-files
RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
