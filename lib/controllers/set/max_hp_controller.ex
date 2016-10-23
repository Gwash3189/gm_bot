defmodule GmBot.Controllers.Set.MaxHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character
  alias GmBot.Controllers.Helpers

  def handle(%{parts: parts, user: owner}) do
    max_hp = List.last(parts)
      |> Helpers.safe_to_integer

    character_name = List.first(parts)
      |> Helpers.remove_apostrophe

    update(owner, character_name, max_hp)
  end

  defp update(owner, character_name, {:ok, max_hp}) do
    case Character.update(owner, character_name, %{max_hp: max_hp}) do
      {:ok, character} -> success(character.name, character.max_hp)
      {:error, changeset} -> failure(changeset.errors)
    end
  end

  defp update(_, _, _) do
    "Please provide a number for your max hp"
  end

  defp success(name, amount) do
    "#{name}'s max hp has been set to #{amount}"
  end

  defp failure(errors) do
    messages = Enum.map(errors, fn({_, {message, _}}) ->
      message
    end)
    Enum.join(messages, """
    """)
  end

  def help, do: """
  - `set <character name> max hp to 30` Sets a characters max hp to the provided value
    Example: ```
      <user> @gm_bot set Drake Daverell III max hp to 54
      <gm_bot> Drake Daverell III's max hp has been set to 54
    ```
  """
end
