defmodule GmBot.Controllers.Set.StatsController do
  defmacro handle_stat_change_for(stat_atom) do
    stat_string = Atom.to_string(stat_atom)
    short_stat_string = String.slice(stat_string, 0..2) |> String.capitalize
    modifier_atom = String.to_atom(stat_string<>"_modifier")

    quote do
      @behaviour GmBot.Controllers
      alias GmBot.Controllers.Helpers
      alias GmBot.Models.Character
      require Logger

      def handle(state) do
        name = Helpers.get_character_name(state)
        stat_value = Helpers.get_stat_value(state)

        case Helpers.safe_int?(stat_value) do
          true -> handle_stat_change(name, stat_value, state)
          false -> result(stat_value)
        end
      end

      defp handle_stat_change(name, safe_int_tuple, %{user: owner} = state) do
        modifier = Helpers.get_modifier(state)
        character = Map.put(%{}, unquote(stat_atom), elem(safe_int_tuple, 1))

        case modifier do
          {:ok, modifier} ->
            modifier_map = Map.put(%{}, unquote(modifier_atom), modifier)
            character = Map.merge(character, modifier_map)
            Character.update(owner, name, character)
              |> result
          {:error, :no_modifier} ->
            modifier_map = Map.put(%{}, unquote(modifier_atom), 0)
            character = Map.merge(character, modifier_map)
            Character.update(owner, name, character)
              |> result
          {:error, :non_safe_int} -> result(modifier)
        end
      end

      defp result({:ok, character}), do:
        success(character.name, Map.get(character, unquote(stat_atom)), Map.get(character, unquote(modifier_atom)))
      defp result({:error, error}), do:
        failure({:error, error})

      defp success(name, stat, nil), do:
        "#{name}'s strength has been set to #{stat}"
      defp success(name, stat, modifier) do
        case modifier > -1 do
          true -> "#{name}'s strength has been set to #{stat} (+#{modifier})"
          false -> "#{name}'s strength has been set to #{stat} (-#{modifier})"
        end
      end
      defp failure({:error, :non_safe_int}), do:
        "Please provide only numbers in your #{unquote(stat_string)} score"
      defp failure({:error, changeset}), do:
        Helpers.print_errors(changeset)
      defp failure(error), do:
        IO.inspect error

      def help do
        """
        Use any of the following ways to set your #{unquote(stat_string)}

        - `set <character name> #{unquote(stat_string)} to <stat amount> (<-|+><modifier amount>)`
        - `set <character name> #{unquote(short_stat_string)}: <stat amount> (<-|+><modifier amount>)`

          Example: ```
            <user> @gm_bot set Drake Daverell III #{unquote(stat_string)} to 12 (+2)
            <gm_bot> Drake Daverell III's #{unquote(stat_string)} has been set to 12 (+2)
          ```

          Example: ```
            <user> @gm_bot set Drake Daverell III #{unquote(short_stat_string)}: 12 (+2)
            <gm_bot> Drake Daverell III's #{unquote(stat_string)} has been set to 12 (+2)
          ```
        """
      end
    end
  end
end
