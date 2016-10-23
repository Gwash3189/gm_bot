use Mix.Config

config :logger,
  compile_time_purge_level: :debug,
  backends: [{LoggerFileBackend, :log}]

config :logger, :log,
  path: "/gm_bot/gm_bot.log",
  level: :debug
