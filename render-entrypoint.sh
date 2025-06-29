# render-entrypoint.sh  ── inicia Puma e Sidekiq no mesmo container
#!/usr/bin/env bash
set -e

# Inicia o servidor web (Puma) em background
bundle exec rails s -p "${PORT:-3000}" -b 0.0.0.0 &

# Inicia o Sidekiq com a concorrência desejada
bundle exec sidekiq -C config/sidekiq.yml -c "${SIDEKIQ_CONCURRENCY:-3}" &

# Fica aguardando; se qualquer processo morrer, o container termina e o Render reinicia
wait -n