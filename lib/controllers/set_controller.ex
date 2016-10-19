defmodule GmBot.Controllers.SetController do
  @behaviour GmBot.Controllers

  def handle(%{parts: _parts, user: _user}) do
    "Set"
  end

  def help do
    # """
    # - `register <character name>` Registers a character so you can track stats and hp
    #   Example: ```
    #     <user> register Drake Daverell III
    #     <gm_bot> Drake Daverell III has been registerd
    #   ```
    # """
    "- nothing yet"
  end

end
