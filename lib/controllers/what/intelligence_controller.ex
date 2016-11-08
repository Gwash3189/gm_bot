defmodule GmBot.Controllers.What.IntelligenceController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:intelligence, :intelligence_modifier],
    success: fn(%{name: name, intelligence: intelligence, intelligence_modifier: modifier}) ->
      cond do
        modifier > -1 ->
          "#{name}'s intelligence is #{intelligence} (+#{modifier})"
        modifier <= -1 ->
          "#{name}'s intelligence is #{intelligence} (-#{modifier})"
        modifier == nil ->
          "#{name}'s intelligence is #{intelligence}"
      end
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> intelligence` Displays the characters intelligence
        Example: ```
          <user> @gm_bot what is Drake Daverell III intelligence
          <gm_bot> Drake Daverell III's intelligence is 14 (+2)
        ```
      """
    end]
end
