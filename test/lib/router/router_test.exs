defmodule GmBot.Tests.Router do
  use ExUnit.Case

  defmodule TestController do
    def handle(_) do
      "handle"
    end

    def custom(_) do
      "custom"
    end
  end

  defmodule OtherTestController do
    def handle(_) do
      "other test controller"
    end
  end

  defmodule TestRoute do
    import GmBot.Router

    route action: "test", dispatch_to: TestController
    route action: "custom", dispatch_to: TestController, call: :custom
    contains? [{"this text", TestController}, {"text", OtherTestController}]

    default "default"
  end

  describe "when the route macro is used" do
    test "it routes to the provied module" do
      assert TestRoute.route(%{action: "test"}) == "handle"
    end
  end

  describe "when the call option is provided" do
    test "it calls that method instead of handle" do
      assert TestRoute.route(%{action: "custom"}) == "custom"
    end
  end

  describe "when the route contains the text" do
    test "it routes to the controller" do
      assert TestRoute.route_contains?(%{text: "this text is awesome"}) == "handle"
    end
  end

  describe "when there are multiple contains routes" do
    test "it routes to the correct controller" do
      assert TestRoute.route_contains?(%{text: "text"}) == "other test controller"
    end
  end

  describe "when the route does not contain the text" do
    test "it does not route to the controller" do
      assert TestRoute.route_contains?(%{text: "no match"}) == "default"
    end
  end
end
