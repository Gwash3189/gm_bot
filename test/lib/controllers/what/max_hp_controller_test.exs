defmodule GmBot.Tests.Controllers.What.MaxHpController do
  use ExUnit.Case
  use TestHelpers.ModelCase

  alias GmBot.Models.Character

  def value, do: 30
  def user, do: "123"
  def name, do: "name"
  def invalid_name, do: "invalid_name"

  def state, do: %{user: user, name: name}
  def invalid_state, do: %{user: user, name: invalid_name}

  describe "when getting a characters max hp" do
    test "it returns a valid message" do
      expected = "#{name}'s max hp is #{value}."
      %Character{name: name, owner: user, max_hp: value}
        |> Character.changeset
        |> GmBot.Repo.insert

      message = GmBot.Controllers.What.MaxHpController.handle(state)

      assert message == expected
    end
  end

  describe "when the incorrect name is provided" do
    test "it returns a message telling them so" do
      expected = "You don't have a character by that name. Try registering one."
      %Character{name: name, owner: user, max_hp: value}
        |> Character.changeset
        |> GmBot.Repo.insert

      message = GmBot.Controllers.What.MaxHpController.handle(invalid_state)

      assert message == expected
    end
  end
end
