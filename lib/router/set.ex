defmodule GmBot.Routers.Set do
  import GmBot.Router

  contains? [
    {"max hp", GmBot.Controllers.Set.MaxHpController},
    {"hp", GmBot.Controllers.Set.CurrentHpController},

    {"strength", GmBot.Controllers.Set.StrengthController},
    {"str", GmBot.Controllers.Set.StrengthController},

    {"dexterity", GmBot.Controllers.Set.StatsController},
    {"dex", GmBot.Controllers.Set.StatsController},

    {"constitution", GmBot.Controllers.Set.StatsController},
    {"con", GmBot.Controllers.Set.StatsController},

    {"intelligence", GmBot.Controllers.Set.StatsController},
    {"int", GmBot.Controllers.Set.StatsController},

    {"wisdom", GmBot.Controllers.Set.StatsController},
    {"wis", GmBot.Controllers.Set.StatsController},

    {"charisma", GmBot.Controllers.Set.StatsController},
    {"cha", GmBot.Controllers.Set.StatsController}
  ]

  default "I'm not sure i know how to set that. Try asking for help."
end
