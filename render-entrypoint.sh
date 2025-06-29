#!/bin/sh
set -e

# Inicia o servidor web (Puma) em background
bundle exec rails s -p "${PORT:-3000}" -b 0.0.0.0 &
PUMA_PID=$!


echo "!!!!!! Iniciou Puma"

# Inicia o Sidekiq em background
bundle exec sidekiq -C config/sidekiq.yml -c 2 &
SIDEKIQ_PID=$!

echo "!!!!!! Iniciou Sidekiq"

# Se matar o contêiner, repasse o sinal aos filhos
trap 'kill $PUMA_PID $SIDEKIQ_PID' INT TERM

# Espera ambos os processos (não há wait -n no /bin/sh)
wait