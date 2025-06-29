# Dockerfile  ── usa a imagem oficial como base
FROM docker.io/chatwoot/chatwoot:v4.2.0

# Copia o seu entrypoint customizado
COPY render-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/render-entrypoint.sh

# Define o comando padrão
CMD ["/bin/sh", "/usr/local/bin/render-entrypoint.sh"]