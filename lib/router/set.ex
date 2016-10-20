defmodule GmBot.Routers.Set do
  import GmBot.Router

  contains? [{"max hp", GmBot.Controllers.Set.MaxHpController}]
end
