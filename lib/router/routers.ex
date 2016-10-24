defmodule GmBot.Routers do
  alias GmBot.Controllers
  alias GmBot.Routers
  import GmBot.Router

  route action: "register", dispatch_to: Controllers.RegisterController
  route action: "version", dispatch_to: Controllers.VersionController
  route action: "hi", dispatch_to: Controllers.PingController
  route action: "hello", dispatch_to: Controllers.PingController
  route action: "help", dispatch_to: Controllers.HelpController
  route action: "set", dispatch_to: Routers.Set, call: :route_contains?
  route action: "what", dispatch_to: Routers.What, call: :route_contains?

  default "I'm not sure what you're asking me to do, try asking for help."
end
