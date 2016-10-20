defmodule GmBot.Controllers do
    @type state :: SimplerSlack.Client.message_state
    @callback handle(state) :: String.t
    @callback help :: String.t
end
