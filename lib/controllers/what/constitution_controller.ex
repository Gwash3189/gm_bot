defmodule GmBot.Controllers.What.ConstitutionController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:constitution, :constitution_modifier],
    success: fn(%{name: name, constitution: constitution, constitution_modifier: modifier}) ->
      cond do
        modifier > -1 ->
          "#{name}'s constitution is #{constitution} (+#{modifier})"
        modifier <= -1 ->
          "#{name}'s constitution is #{constitution} (-#{modifier})"
        modifier == nil ->
          "#{name}'s constitution is #{constitution}"
      end
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> constitution` Displays the characters constitution
        Example: ```
          <user> @gm_bot what is Drake Daverell III constitution
          <gm_bot> Drake Daverell III's constitution is 14 (+2)
        ```
      """
    end]
end
