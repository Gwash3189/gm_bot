#!/bin/bash
date
echo "======================"
echo "pulling"
echo "======================"
git pull
echo "======================"
echo "cleaning and compiling"
echo "======================"
MIX_ENV=prod mix clean && MIX_ENV=prod mix deps.get && MIX_ENV=prod mix compile
echo "======================"
echo "killing beam"
echo "======================"
pkill beam
echo "======================"
echo "migrating"
echo "======================"
MIX_ENV=prod mix ecto.migrate
echo "======================"
echo "starting service again"
echo "======================"
MIX_ENV=prod elixir --detached -S mix run --no-halt
