#!/bin/bash
npm install -g github-webhook
mix ecto.create && mix ecto.migrate
echo "running webhook server"
github-webhook --config webhook.secret.json
