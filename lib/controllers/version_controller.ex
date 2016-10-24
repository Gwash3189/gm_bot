defmodule GmBot.Controllers.VersionController do
  @behaviour GmBot.Controllers

  def handle(_) do
  {:ok, contents} = File.read("./.version")
  contents
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
