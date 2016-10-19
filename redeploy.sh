#!/bin/bash
date
echo "======================"
echo "pulling"
echo "======================"
git pull
echo "======================"
echo "cleaning and compiling"
echo "======================"
rm -rf _build && mix clean && mix deps.clean --all && mix deps.get && MIX_ENV=prod mix compile
echo "======================"
echo "killing beam"
echo "======================"
pkill beam
echo "======================"
echo "migrating"
echo "======================"
mix ecto.migrate
echo "======================"
echo "starting service again"
echo "======================"
MIX_ENV=prod elixir --detached -S mix run --no-halt > gm_bot.log
