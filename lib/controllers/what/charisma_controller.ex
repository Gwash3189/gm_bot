defmodule GmBot.Controllers.What.CharismaController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:charisma, :charisma_modifier],
    success: fn(%{name: name, charisma: charisma, charisma_modifier: modifier}) ->
      cond do
        modifier > -1 ->
          "#{name}'s charisma is #{charisma} (+#{modifier})"
        modifier <= -1 ->
          "#{name}'s charisma is #{charisma} (-#{modifier})"
        modifier == nil ->
          "#{name}'s charisma is #{charisma}"
      end
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> charisma` Displays the characters charisma
        Example: ```
          <user> @gm_bot what is Drake Daverell III charisma
          <gm_bot> Drake Daverell III's charisma is 14 (+2)
        ```
      """
    end]
end
