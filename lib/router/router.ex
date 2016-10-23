defmodule GmBot.Router do
  defmacro default(str) when is_binary(str) do
    quote do
      def route(_) do
        unquote(str)
      end

      def default_route_contains?(_) do
        unquote(str)
      end
    end
  end
  defmacro route(opts) do
    provided_action = Keyword.get(opts, :action)
    call = Keyword.get(opts, :call, :handle)
    capital_action = String.capitalize(provided_action)
    module = Keyword.get(opts, :dispatch_to)
    quote do
      def route(%{action: unquote(provided_action)} = state) do
        apply(unquote(module), unquote(call), [state])
      end
      def route(%{action: unquote(capital_action)} = state) do
        apply(unquote(module), unquote(call), [state])
      end
    end
  end

  defmacro contains?(matches, opts \\ []) do
    call = Keyword.get(opts, :call, :handle)
    quote do
      def route_contains?(%{text: text} = state) do
        pair = Enum.find(unquote(matches), fn({str, module}) ->
          if String.contains?(text, str) do
            {str, module}
          end
        end)

        case pair do
          {str, module} ->
            apply(module, unquote(call), [state])
          _ ->
            __MODULE__.default_route_contains?(state)
        end
      end
    end
  end
end
