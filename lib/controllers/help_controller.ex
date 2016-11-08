defmodule GmBot.Controllers.HelpController do
  @behaviour GmBot.Controllers

  def handle(_) do
    """
    Hi! I'm your frendly GM Bot and I can do a couple useful things

    *Commands*
    #{GmBot.Controllers.RegisterController.help}
    #{GmBot.Controllers.Set.MaxHpController.help}
    #{GmBot.Controllers.What.MaxHpController.help}
    #{GmBot.Controllers.Set.CurrentHpController.help}
    #{GmBot.Controllers.What.CurrentHpController.help}
    #{GmBot.Controllers.Set.CurrentHpController.help}
    #{GmBot.Controllers.What.CharismaController.help}
    #{GmBot.Controllers.Set.CharismaController.help}
    #{GmBot.Controllers.What.ConstitutionController.help}
    #{GmBot.Controllers.Set.ConstitutionController.help}
    #{GmBot.Controllers.What.DexterityController.help}
    #{GmBot.Controllers.Set.DexterityController.help}
    #{GmBot.Controllers.What.IntelligenceController.help}
    #{GmBot.Controllers.Set.IntelligenceController.help}
    #{GmBot.Controllers.What.StrengthController.help}
    #{GmBot.Controllers.Set.StrengthController.help}
    #{GmBot.Controllers.What.WisdomController.help}
    #{GmBot.Controllers.Set.WisdomController.help}
    #{GmBot.Controllers.VersionController.help}
    """
  end

  def help, do: ""


end
