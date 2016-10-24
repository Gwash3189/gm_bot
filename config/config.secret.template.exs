use Mix.Config

config :gm_bot, GmBot.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "secret",
  username: "secret",
  password: "secret",
  hostname: "secret",
  port: "5432"


config :gm_bot,
  token: ""
