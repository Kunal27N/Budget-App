#!/bin/bash
set -e

# Wait for Postgres
until pg_isready -h "$DATABASE_HOST" -U "$DATABASE_USERNAME"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

# Prepare the database
bundle exec rails db:prepare

exec "$@"
