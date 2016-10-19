defmodule GmBot.Controllers do
  import GmBot.Router

  route action: "register", controller: RegisterController
  route action: "set", controller: SetController
  route action: "hi", controller: PingController
  route action: "hello", controller: PingController
  route action: "help", controller: HelpController
  route "I'm not sure what you're asking me to do, try asking for help."

  @type state :: SimplerSlack.Client.message_state
  @callback handle(state) :: String.t
  @callback help :: String.t
end
