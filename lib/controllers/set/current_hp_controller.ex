defmodule GmBot.Controllers.Set.CurrentHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character
  alias GmBot.Controllers.Helpers

  def handle(%{parts: parts, user: owner}) do
    current_hp = List.last(parts)
      |> Helpers.safe_to_integer

    character_name = List.first(parts)
      |> Helpers.remove_apostrophe

    update(owner, character_name, current_hp)
  end

  defp update(owner, character_name, {:ok, current_hp}) do
    case Character.update(owner, character_name, %{current_hp: current_hp}) do
      {:ok, character} -> success(character.name, character.current_hp)
      {:error, changeset} -> failure(changeset.errors)
    end
  end

  defp update(_, _, _) do
    "Please provide a number for your hp"
  end

  defp success(name, amount) do
    "#{name}'s current hp has been set to #{amount}"
  end

  defp failure(errors) do
    messages = Enum.map(errors, fn({_, {message, _}}) ->
      message
    end)
    Enum.join(messages, """
    """)
  end

  def help, do: """
  - `set <character name> current hp to 30` Sets a characters current hp to the provided value
    Example: ```
      <user> @gm_bot set Drake Daverell III current hp to 54
      <gm_bot> Drake Daverell III's current hp has been set to 54
    ```
  """
end
