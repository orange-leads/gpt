#!/usr/bin/env bash
set -euo pipefail
APP_DIR=/srv/astreya
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# Если репо ещё не клонировано — клонируем, иначе делаем git pull
if [ ! -d .git ]; then
  git clone --depth=1 https://github.com/orange-leads/gpt.git .
else
  git pull --ff-only
fi

docker compose -f docker/docker-compose.yml pull
docker compose -f docker/docker-compose.yml up -d --remove-orphans
echo "✅ Deploy complete at $(date)"
