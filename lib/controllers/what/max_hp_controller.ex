defmodule GmBot.Controllers.What.MaxHpController do
  import GmBot.Controllers.What.WhatController

  retrieve [
    stats: [:max_hp],
    success: fn(%{name: name, max_hp: max_hp}) ->
      "#{name}'s max hp is #{max_hp}."
    end,
    failure: fn() ->
      "You don't have a character by that name. Try registering one."
    end,
    help: fn() ->
      """
      - `what is <character name> max hp` Displays the characters max hp
        Example: ```
          <user> @gm_bot what is Drake Daverell III max hp
          <gm_bot> Drake Daverell III's max hp is 54
        ```
      """
    end]
end
