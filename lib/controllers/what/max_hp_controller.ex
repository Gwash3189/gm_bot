defmodule GmBot.Controllers.What.MaxHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character

  def handle(%{parts: parts, user: owner}) do
    # what is test's my max hp
    character_name = List.delete(parts, "is")
      |> List.first

    IO.inspect character_name
    character_name = String.replace(character_name, "’s", "")
    IO.inspect character_name

    case Character.get(owner, character_name) do
      nil -> failure
      character -> success(character.name, character.max_hp)
    end
  end

  defp success(name, amount) do
    "#{name}'s max hp is #{amount}"
  end

  defp failure do
    "Something went wrong!"
  end

  def help, do: ""
end
