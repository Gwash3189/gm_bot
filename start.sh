#!/bin/bash
npm install -g github-webhook
mix ecto.create && mix ecto.migrate
github-webhook --config webhook.secret.json
