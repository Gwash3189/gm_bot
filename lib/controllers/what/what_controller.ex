defmodule GmBot.Controllers.What.WhatController do
  defmacro retrieve(options) do
    atoms_to_retrieve = Keyword.get(options, :stats, [])
    success_callback = Keyword.get(options, :success)
    failure_callback = Keyword.get(options, :failure)
    help_callback = Keyword.get(options, :help)

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
        stats = Enum.reduce(unquote(atoms_to_retrieve), %{}, fn(stat_atom, acc) ->
          stat_value = Map.get(char, stat_atom)
          Map.put(acc, stat_atom, stat_value)
        end)
        stats = Map.merge(stats, %{name: Map.get(char, :name)})
        unquote(success_callback).(stats)
      end

      defp failure(:no_character_found), do:
        unquote(failure_callback).()

      def help, do: unquote(help_callback).()
    end
  end
end
