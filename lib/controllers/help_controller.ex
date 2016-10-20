defmodule GmBot.Controllers.HelpController do
  @behaviour GmBot.Controllers

  def handle(_) do
    """
    Hi! I'm your frendly GM Bot and I can do a couple useful things

    *Commands*
    #{GmBot.Controllers.RegisterController.help}
    #{GmBot.Controllers.Set.MaxHpController.help}
    #{GmBot.Controllers.What.MaxHpController.help}
    """
  end

  def help, do: ""


end
