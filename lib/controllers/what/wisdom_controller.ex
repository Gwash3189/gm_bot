defmodule GmBot.Controllers.What.WisdomController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:wisdom, :wisdom_modifier],
    success: fn(%{name: name, wisdom: wisdom, wisdom_modifier: modifier}) ->
      cond do
        modifier > -1 ->
          "#{name}'s wisdom is #{wisdom} (+#{modifier})"
        modifier <= -1 ->
          "#{name}'s wisdom is #{wisdom} (-#{modifier})"
        modifier == nil ->
          "#{name}'s wisdom is #{wisdom}"
      end
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> wisdom` Displays the characters wisdom
        Example: ```
          <user> @gm_bot what is Drake Daverell III wisdom
          <gm_bot> Drake Daverell III's wisdom is 14 (+2)
        ```
      """
    end]
end
