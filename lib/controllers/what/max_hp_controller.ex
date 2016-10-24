defmodule GmBot.Controllers.What.MaxHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character

  def handle(state), do:
    Character.get(state)
      |> result

  defp result(%Character{} = character), do:
    success(character)
  defp result(:no_character_found), do:
    failure(:no_character_found)

  defp success(%Character{name: name, max_hp: max_hp}), do:
    "#{name}'s max hp is #{max_hp}."

  defp failure(:no_character_found), do:
    "You don't have a character by that name. Try registering one."

  def help, do: """
  - `what is <character name> max hp` Displays the characters max hp
    Example: ```
      <user> @gm_bot what is Drake Daverell III max hp
      <gm_bot> Drake Daverell III's max hp is 54
    ```
  """
end
