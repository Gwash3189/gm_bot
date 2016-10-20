defmodule GmBot.Controllers.What.MaxHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character

  def handle(%{parts: parts, user: owner}) do
    character_name = List.delete(parts, "is")
      |> List.first

    character_name = String.replace(character_name, "’s", "")

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

  def help, do: """
  - `what is <character name> max hp` Displays the characters max hp
    Example: ```
      <user> @gm_bot what is Drake Daverell III max hp
      <gm_bot> Drake Daverell III's max hp is 54
    ```
  """
end
