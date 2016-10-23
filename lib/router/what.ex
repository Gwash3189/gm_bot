defmodule GmBot.Routers.What do
  import GmBot.Router

  contains? [
    {"max hp", GmBot.Controllers.What.MaxHpController},
    {"hp", GmBot.Controllers.What.CurrentHpController}
  ]

  default "I'm don't know what that is. Try asking for help."
end
