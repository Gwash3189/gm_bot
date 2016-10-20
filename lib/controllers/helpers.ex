defmodule GmBot.Controllers.Helpers do
  def remove_apostrophe(str) do
    String.replace(str, "'s", "")
      |> String.replace("’s", "")
  end
end
