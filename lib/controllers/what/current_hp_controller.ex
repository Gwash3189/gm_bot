defmodule GmBot.Controllers.What.CurrentHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character

  def handle(state), do:
    Character.get(state)
      |> result

  defp result(%Character{} = character), do:
    success(character)
  defp result(:no_character_found), do:
    failure(:no_character_found)

  defp success(%Character{name: name, current_hp: current_hp}), do:
    "#{name}'s current hp is #{current_hp}."

  defp failure(:no_character_found), do:
    "You don't have a character by that name. Try registering one."

  def help, do: """
  - `what is <character name> current hp` Displays the characters current hp
    Example: ```
      <user> @gm_bot what is Drake Daverell III current hp
      <gm_bot> Drake Daverell III's current hp is 54
    ```
  """
end
