defmodule GmBot.Websocket do
  use SimplerSlack

  def slack_message(%{text: text, self: %{id: id}} = state) do
    [action|parts] = remove_bot_id(id, text)
      |> String.split(" ")

    Map.merge(%{action: action, parts: parts}, state)
      |> GmBot.Routers.route
      |> send_message(state[:channel], state[:token])
  end

  def remove_bot_id(id, str) do
    String.replace(str, format_user_id(id), "")
      |> String.strip
  end

end
