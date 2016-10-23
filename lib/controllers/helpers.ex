defmodule GmBot.Controllers.Helpers do
  def remove_apostrophe(str) do
    String.replace(str, "'s", "")
      |> String.replace("’s", "")
  end

  def safe_to_integer(str) do
    try do
      {:ok, String.to_integer(str)}
    rescue
      _ -> {:error, nil}
    end
  end
end
