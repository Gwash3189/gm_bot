defmodule GmBot.Routers.Set do
  import GmBot.Router

  contains? [
    {"max hp", GmBot.Controllers.Set.MaxHpController},
    {"hp", GmBot.Controllers.Set.CurrentHpController},

    {"strength", GmBot.Controllers.Set.StrengthController},
    {"str", GmBot.Controllers.Set.StrengthController},
    {"STR", GmBot.Controllers.Set.StrengthController}

    {"dexterity", GmBot.Controllers.Set.DexterityController},
    {"dex", GmBot.Controllers.Set.DexterityController},
    {"DEX", GmBot.Controllers.Set.DexterityController}

    {"constitution", GmBot.Controllers.Set.ConstitutionController},
    {"con", GmBot.Controllers.Set.ConstitutionController},
    {"CON", GmBot.Controllers.Set.ConstitutionController}

    {"intelligence", GmBot.Controllers.Set.IntelligenceController},
    {"int", GmBot.Controllers.Set.IntelligenceController},
    {"INT", GmBot.Controllers.Set.IntelligenceController}

    {"wisdom", GmBot.Controllers.Set.WisdomController},
    {"wis", GmBot.Controllers.Set.WisdomController},
    {"WIS", GmBot.Controllers.Set.WisdomController}

    {"charisma", GmBot.Controllers.Set.CharismaController},
    {"cha", GmBot.Controllers.Set.CharismaController},
    {"CHA", GmBot.Controllers.Set.CharismaController}
  ]

  default "I'm not sure i know how to set that. Try asking for help."
end
