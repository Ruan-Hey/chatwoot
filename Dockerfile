# Dockerfile  ── usa a imagem oficial como base
FROM docker.io/chatwoot/chatwoot:v4.2.0

# Copia o seu entrypoint customizado
COPY render-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/render-entrypoint.sh

# Define o comando padrão
CMD ["/usr/bin/render-entrypoint.sh"]