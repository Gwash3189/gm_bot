defmodule GmBot.Router do
  defmacro route(str) when is_binary(str) do
    quote do
      def route(_) do
        unquote(str)
      end
    end
  end
  defmacro route(opts) do
    provided_action = Keyword.get(opts, :action)
    cap_action = String.capitalize(provided_action)
    controller = Keyword.get(opts, :controller)
    quote do
      def route(%{action: unquote(provided_action)} = state) do
        GmBot.Controllers.unquote(controller).handle(state)
      end
      def route(%{action: unquote(cap_action)} = state) do
        GmBot.Controllers.unquote(controller).handle(state)
      end
    end
  end
end
