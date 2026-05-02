FROM haskell:9.8.4

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libsqlite3-dev \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

COPY . .

RUN cabal update && \
    cabal build && \
    cp "$(cabal list-bin rpg-engine)" /usr/local/bin/rpg-engine

EXPOSE 3000

CMD ["rpg-engine"]