defmodule GmBot.Tests.Controllers.Set.MaxHpController do
  use ExUnit.Case
  use TestHelpers.ModelCase

  alias GmBot.Models.Character

  def user, do: "123"
  def name, do: "name"

  def value, do: 30
  def text, do: "#{name}'s max hp to #{value}"
  def parts, do: String.split(text, " ")
  def state, do: %{parts: parts, user: user, text: text}

  def invalid_value, do: "x"
  def invalid_text, do: "#{name}'s max hp to #{invalid_value}"
  def invalid_parts, do: String.split(invalid_text, " ")
  def invalid_state, do: %{parts: invalid_parts, user: user, text: invalid_text}

  describe "when setting a characters max hp" do
    test "it returns a valid message" do
      expected = "#{name}'s max hp has been set to #{value}."
      %Character{name: name, owner: user}
        |> Character.changeset
        |> GmBot.Repo.insert

      message = GmBot.Controllers.Set.MaxHpController.handle(state)

      assert message == expected
    end
  end

  describe "when the hp is not a number" do
    test "it returns a message telling you so" do
      expected = "Please provide a number for your hp."
      %Character{name: name, owner: user}
        |> Character.changeset
        |> GmBot.Repo.insert

      message = GmBot.Controllers.Set.MaxHpController.handle(invalid_state)

      assert message == expected
    end
  end
end
