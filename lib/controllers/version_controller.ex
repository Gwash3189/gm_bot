defmodule GmBot.Controllers.VersionController do
  @behaviour GmBot.Controllers

  def handle(%{parts: parts, user: owner}) do
    File.read("./.version")
  end

  def help do
    """
    - `version` tells you what the latest changes are
      Example: ```
        <user> @gm_bot version
        <gm_bot> https://github.com/Gwash3189...
      ```
    """
  end
end
