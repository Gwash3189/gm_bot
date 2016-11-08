defmodule GmBot.Controllers.What.StrengthController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:strength, :strength_modifier],
    success: fn(%{name: name, strength: strength, strength_modifier: modifier}) ->
      cond do
        modifier > -1 ->
          "#{name}'s strength is #{strength} (+#{modifier})"
        modifier <= -1 ->
          "#{name}'s strength is #{strength} (-#{modifier})"
        modifier == nil ->
          "#{name}'s strength is #{strength}"
      end
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> strength` Displays the characters strength
        Example: ```
          <user> @gm_bot what is Drake Daverell III strength
          <gm_bot> Drake Daverell III's strength is 14 (+2)
        ```
      """
    end]
end
