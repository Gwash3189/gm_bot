defmodule GmBot.Controllers.Set.MaxHpController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character
  alias GmBot.Controllers.Helpers

  def handle(%{parts: parts, user: owner}) do
    max_hp = List.last(parts)
      |> String.to_integer

    character_name = List.first(parts)
      |> Helpers.remove_apostrophe

    case Character.update(owner, character_name, %{max_hp: max_hp}) do
      {:ok, character} -> success(character.name, character.max_hp)
      {:error, changeset} -> failure(changeset.errors)
    end
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

  def help, do: ""
end
