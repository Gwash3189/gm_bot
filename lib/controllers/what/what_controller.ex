defmodule GmBot.Controllers.What.WhatController do
  defmacro retrieve(stat_atom) do
    stat_full_name = Atom.to_string(stat_atom)
      |> String.replace("_", " ")

    quote do
      @behaviour GmBot.Controllers
      alias GmBot.Models.Character

      def handle(state) do
        name = GmBot.Controllers.Helpers.get_character_name(state)
        Map.put(state, :name, name)
          |> Character.get
          |> result
      end

      defp result(%Character{} = character), do:
        success(character)
      defp result(:no_character_found), do:
        failure(:no_character_found)

      defp success(char) do
        stat = Map.get(char, unquote(stat_atom))
        name = Map.get(char, :name)
        "#{name}'s #{unquote(stat_full_name)} is #{stat}."
      end

      defp failure(:no_character_found), do:
        "You don't have a character by that name. Try registering one."

      def help, do: """
      - `what is <character name> #{unquote(stat_full_name)}` Displays the characters #{unquote(stat_full_name)}
        Example: ```
          <user> @gm_bot what is Drake Daverell III #{unquote(stat_full_name)}
          <gm_bot> Drake Daverell III's #{unquote(stat_full_name)} is 54
        ```
      """
    end
  end
end
