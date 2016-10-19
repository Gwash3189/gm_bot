defmodule GmBot.Controllers.RegisterController do
  @behaviour GmBot.Controllers
  alias GmBot.Models.Character

  def handle(%{parts: parts, user: user}) do
    name = Enum.join(parts, " ")
    character = %Character{name: name, owner: user}
    changeset = Character.changeset(character)

    case GmBot.Repo.insert(changeset) do
      {:ok, character} -> success(character.name)
      {:error, changeset} -> failure(changeset.errors)
    end
  end

  def help do
    """
    - `register <character name>` Registers a character so you can track stats and hp
      Example: ```
        <user> register Drake Daverell III
        <gm_bot> Drake Daverell III has been registerd
      ```
    """
  end

  defp success(name) do
    "#{name} has been registerd."
  end

  defp failure(errors) do
    messages = Enum.map(errors, fn({_, {message, _}}) ->
      message
    end)
    Enum.join(messages, """
    """)
  end

end
