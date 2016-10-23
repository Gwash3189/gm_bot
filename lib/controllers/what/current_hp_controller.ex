defmodule GmBot.Controllers.What.CurrentHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character
  alias GmBot.Controllers.Helpers

  def handle(%{parts: parts, user: owner}) do
    character_name = List.delete(parts, "is")
      |> List.first
      |> Helpers.remove_apostrophe

    case Character.get(owner, character_name) do
      nil -> failure
      character -> success(character.name, character.current_hp)
    end
  end

  defp success(name, amount) do
    "#{name}'s current hp is #{amount}"
  end

  defp failure do
    "Something went wrong!"
  end

  def help, do: """
  - `what is <character name> current hp` Displays the characters current hp
    Example: ```
      <user> @gm_bot what is Drake Daverell III current hp
      <gm_bot> Drake Daverell III's current hp is 54
    ```
  """
end
