defmodule GmBot.Routers.Set do
  import GmBot.Router

  contains? [
    {"max hp", GmBot.Controllers.Set.MaxHpController},
    {"hp", GmBot.Controllers.Set.CurrentHpController}
  ]

  default "I'm not sure i know how to set that. Try asking for help."
end
