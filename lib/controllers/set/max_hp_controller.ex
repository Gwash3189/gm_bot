defmodule GmBot.Controllers.Set.MaxHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Controllers.Helpers

  def handle(state), do:
    Helpers.update_character_with(:max_hp, state)
      |> result

  defp result({:ok, character}), do:
    success(character.name, character.max_hp)
  defp result({:error, :non_safe_int}), do:
    failure(:non_safe_int)
  defp result({:error, changeset}), do:
    failure(changeset)
  defp result(_), do:
    "Please provide a number for your hp."

  defp success(name, amount), do:
    "#{name}'s max hp has been set to #{amount}."

  defp failure(:non_safe_int), do:
    "Please provide a number for your hp."
  defp failure(errors), do:
    Helpers.print_errors(errors)

  def help, do: """
  - `set <character name> max hp to 30` Sets a characters max hp to the provided value
    Example: ```
      <user> @gm_bot set Drake Daverell III max hp to 54
      <gm_bot> Drake Daverell III's max hp has been set to 54
    ```
  """
end
