FROM python:3.12-slim

# eMudhra: refresh the OS trust store for this security update.
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

LABEL name="WAStream" \
      description="Stremio addon to convert DDL to streams via debrid services" \
      url="https://gitlab.com/10ho/wastream"

WORKDIR /app

COPY pyproject.toml ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir .

COPY . .

EXPOSE 7000

CMD ["python", "-m", "wastream.main"]
