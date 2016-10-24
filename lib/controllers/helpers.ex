defmodule GmBot.Controllers.Helpers do
  def remove_apostrophe(str) do
    String.replace(str, "'s", "")
      |> String.replace("’s", "")
  end

  def safe_to_integer(str) do
    try do
      {:ok, String.to_integer(str)}
    rescue
      _ -> {:error, :non_safe_int}
    end
  end

  def update_character_with(prop, %{user: owner, parts: parts}) do
    safe_integer? = List.last(parts)
      |> safe_to_integer

    character_name = List.first(parts)
      |> remove_apostrophe

      case safe_integer? do
        {:ok, int} ->
          change = Map.put(%{}, prop, int)
          GmBot.Models.Character.update(owner, character_name, change)
        {:error, :non_safe_int} ->
          {:error, :non_safe_int}
      end
  end

  def print_errors(changeset) do
    new_line = """
    """
    errors_map = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, _acc ->
        String.replace(msg, "%{#{key}}", to_string(value))
      end)
    end)

    errors_list = Enum.map(errors_map, fn({key, value}) ->
      "#{key} #{value}"
    end)

    Enum.join(errors_list, new_line)
  end
end
