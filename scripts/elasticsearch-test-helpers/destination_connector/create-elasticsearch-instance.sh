#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$(dirname "$(realpath "$0")")")
ENV_FILE="$SCRIPT_DIR"/common/es-dest-ingest-test-creds.env

# Create the Elasticsearch cluster
docker compose version
docker compose --env-file "$ENV_FILE" -f "$SCRIPT_DIR"/common/docker-compose.yaml up --wait
docker compose --env-file "$ENV_FILE" -f "$SCRIPT_DIR"/common/docker-compose.yaml ps

echo "Cluster is live."
python "$SCRIPT_DIR"/destination_connector/create_index.py
