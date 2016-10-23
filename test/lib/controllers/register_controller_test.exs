defmodule GmBot.Tests.Controllers.RegisterController do
  use ExUnit.Case

  use TestHelpers.ModelCase

  def user, do: "123"
  def name, do: "name"
  def parts, do: [name]
  def state, do: %{parts: parts, user: user}

  describe "when registering a character" do
    test "it returns a message" do
      message = GmBot.Controllers.RegisterController.handle(state)
      expected = "#{name} has been registerd."
      assert message == expected
    end
  end
end
