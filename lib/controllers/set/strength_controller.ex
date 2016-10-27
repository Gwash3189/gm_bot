defmodule GmBot.Controllers.Set.StrengthController do
  @behaviour GmBot.Controllers
  alias GmBot.Controllers.Helpers
  alias GmBot.Models.Character

  def handle(state) do
    name = Helpers.get_character_name(state)
    stat_value = Helpers.get_stat_value(state)

    case Helpers.safe_int?(stat_value) do
      true -> handle_stat_change(name, stat_value, state)
      false -> result(stat_value)
    end
  end

  defp handle_stat_change(name, {:ok, strength}, %{user: owner} = state) do
    modifier = Helpers.get_modifier(state)
    character = %{
      strength: strength
    }

    case modifier do
      {:ok, modifier} ->
        character = Map.merge(character, %{strength_modifier: modifier})
        Character.update(owner, name, character)
          |> result
      {:error, :no_modifier} ->
          Character.update(owner, name, character)
          |> result
      {:error, :non_safe_int} -> result(modifier)
    end
  end

  defp result({:ok, character}), do:
    success(character.name, character.strength, character.strength_modifier)
  defp result({:error, error}), do:
    failure({:error, error})

  defp success(name, stength, nil), do:
    "#{name}'s strength has been set to #{stength}"
  defp success(name, stength, modifier) do
    case modifier > -1 do
      true -> "#{name}'s strength has been set to #{stength} (+#{modifier})"
      false -> "#{name}'s strength has been set to #{stength} (-#{modifier})"
    end
  end
  defp failure({:error, :non_safe_int}), do:
    "Please provide only numbers in your strength score"
  defp failure({:error, changeset}), do:
    Helpers.print_errors(changeset)
  defp failure(error), do:
    IO.inspect error

  def help do
    """
    - `set <character name> <str|STR>(ength) to <amount> (<-|+><amount>)`

      Everything in () is optional.
      Sets a characters strength to the provided value.
      The modifier is option.

      Example: ```
        <user> @gm_bot set Drake Daverell III strength to 12 (+2)
        <gm_bot> Drake Daverell III's max hp has been set to 54
      ```
    """
  end
end
