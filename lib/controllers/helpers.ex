defmodule GmBot.Controllers.Helpers do
  @clean_modifier_regex ~r/\(|\)|\+/

  def remove_apostrophe(str) do
    String.replace(str, "'s", "")
      |> String.replace("’s", "")
  end

  @type safe_integer :: integer | :non_safe_int
  @spec safe_to_integer(String.t) :: safe_integer
  def safe_to_integer(str) do
    try do
      {:ok, String.to_integer(str)}
    rescue
      _ -> {:error, :non_safe_int}
    end
  end

  def safe_int?({:ok, _}), do: true
  def safe_int?({:error, :non_safe_int}), do: false

  def update_character_with(prop, %{user: owner} = state) do
    safe_integer? = get_stat_value(state)
    character_name = get_character_name(state)

    case safe_integer? do
      {:ok, int} ->
        change = Map.put(%{}, prop, int)
        GmBot.Models.Character.update(owner, character_name, change)
      tup -> tup
    end
  end

  def get_character_name(%{parts: parts}) do
    List.first(parts)
      |> remove_apostrophe
  end

  def get_stat_value(%{parts: parts} = state) do
    if has_modifiers?(state) do
      stat_value_position = length(parts) - 2

      Enum.at(parts, stat_value_position)
        |> safe_to_integer
    else
      List.last(parts)
        |> safe_to_integer
    end
  end

  @type positive_integer :: integer
  @type negative_integer :: integer
  @type modifier? :: {:error, :no_modifier} | positive_integer | negative_integer
  @spec get_modifier(%{parts: List.t}) :: modifier?
  def get_modifier(%{parts: parts} = state) do
    if !has_modifiers?(state) do
      {:error, :no_modifier}
    else
      Enum.reverse(parts)
        |> List.first
        |> String.replace(@clean_modifier_regex, "")
        |> safe_to_integer
    end
  end

  @spec get_modifier_type(map) :: :+ | :-
  def get_modifier_type(%{text: text}) do
    cond do
      String.contains?(text, "+") ->
        :+
      String.contains?(text, "-") ->
        :-
    end
  end

  def has_modifiers?(%{text: text}) do
    String.contains?(text, "+") or String.contains?(text, "-")
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

  def keyword_to_map(keyword_list), do:
    Enum.reduce(keyword_list, %{}, &Map.put(&2, elem(&1, 0), elem(&1, 1)))
end
