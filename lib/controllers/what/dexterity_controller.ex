defmodule GmBot.Controllers.What.DexterityController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:dexterity, :dexterity_modifier],
    success: fn(%{name: name, dexterity: dexterity, dexterity_modifier: modifier}) ->
      cond do
        modifier > -1 ->
          "#{name}'s dexterity is #{dexterity} (+#{modifier})"
        modifier <= -1 ->
          "#{name}'s dexterity is #{dexterity} (-#{modifier})"
        modifier == nil ->
          "#{name}'s dexterity is #{dexterity}"
      end
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> dexterity` Displays the characters dexterity
        Example: ```
          <user> @gm_bot what is Drake Daverell III dexterity
          <gm_bot> Drake Daverell III's dexterity is 14 (+2)
        ```
      """
    end]
end
