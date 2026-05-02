FROM haskell:9.8.4

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libsqlite3-dev \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

COPY . .

RUN stack build --system-ghc && \
    cp "$(stack path --local-install-root)/bin/rpg-engine" /usr/local/bin/rpg-engine

CMD ["rpg-engine"]