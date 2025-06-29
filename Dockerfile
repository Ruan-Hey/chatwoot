# Dockerfile  ── usa a imagem oficial como base
FROM docker.io/chatwoot/chatwoot:v4.2.0

# 1. Garante que bash existe (já vem, mas fica explícito) e converte CRLF → LF
RUN apt-get update && apt-get install -y --no-install-recommends bash dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Copia o seu entrypoint customizado
COPY render-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/render-entrypoint.sh

# Define o comando padrão
CMD ["bash", "/usr/local/bin/render-entrypoint.sh"]