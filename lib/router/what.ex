defmodule GmBot.Routers.What do
  import GmBot.Router

  contains? [
    {"max hp", GmBot.Controllers.What.MaxHpController},
    {"hp", GmBot.Controllers.What.CurrentHpController},

    {"strength", GmBot.Controllers.What.StrengthController},
    {"str", GmBot.Controllers.What.StrengthController},

    {"dexterity", GmBot.Controllers.What.DexterityController},
    {"dex", GmBot.Controllers.What.DexterityController},

    {"constitution", GmBot.Controllers.What.ConstitutionController},
    {"con", GmBot.Controllers.What.ConstitutionController},

    {"intelligence", GmBot.Controllers.What.IntelligenceController},
    {"int", GmBot.Controllers.What.IntelligenceController},

    {"wisdom", GmBot.Controllers.What.WisdomController},
    {"wis", GmBot.Controllers.What.WisdomController},

    {"charisma", GmBot.Controllers.What.CharismaController},
    {"cha", GmBot.Controllers.What.CharismaController}
  ]

  default "I'm don't know what that is. Try asking for help."
end
