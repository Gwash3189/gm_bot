defmodule GmBot.Controllers.What.CurrentHpController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:current_hp],
    success: fn(%{name: name, current_hp: current_hp}) ->
      "#{name}'s current hp is #{current_hp}."
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> current hp` Displays the characters current hp
        Example: ```
          <user> @gm_bot what is Drake Daverell III current hp
          <gm_bot> Drake Daverell III's current hp is 54
        ```
      """
    end]
end
