defmodule GmBot do
  import Supervisor.Spec, warn: false
  use Application

  def start(_, _) do
    children = [
      worker(GmBot.Websocket, [Application.get_env(:gm_bot, :token)]),
      worker(GmBot.Repo, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

end
