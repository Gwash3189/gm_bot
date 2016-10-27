defmodule GmBot.Tests.Controllers.Set.StrengthController do
  use ExUnit.Case
  use TestHelpers.ModelCase

  alias GmBot.Models.Character

  def name, do: "name"
  def user, do: "123"
  def stat, do: "12"
  def modifier(mod \\ "+1"), do: mod
  def text, do: "name's strength to #{stat}"
  def text_short, do: "name's STR: #{stat}"
  def text_modifier, do: "name's strength to #{stat} (#{modifier})"
  def text_non_number, do: "name's strength to ABC"
  def text_non_number_modifier, do: "name's strength to 12 (+ABC)"
  def text_short_modifier, do: "name's STR: #{stat} (#{modifier})"
  def parts(text), do: String.split(text, " ")
  def state(state \\%{}), do: Map.merge(%{
      parts: parts(Map.get(state, :text, text)),
      text: Map.get(state, :text, text),
      user: user
    }, state)

  setup do
    %Character{name: name, owner: user}
      |> Character.changeset
      |> GmBot.Repo.insert
      |> elem(0)
  end

  describe "when provided with a stength score" do
    test "it stores the score" do
      expected = "#{name}'s strength has been set to #{stat}"
      message = GmBot.Controllers.Set.StrengthController.handle(state)

      assert expected == message
    end
  end

  describe "when provided with a stength score and a modifier" do
    test "it stores the score" do
      expected = "#{name}'s strength has been set to #{stat} (#{modifier})"
      message = state(%{ text: text_modifier })
        |> GmBot.Controllers.Set.StrengthController.handle

      assert expected == message
    end
  end

  describe "when provided with a short stength score" do
    test "it stores the score" do
      expected = "#{name}'s strength has been set to #{stat}"
      message = state(%{ text: text_short })
        |> GmBot.Controllers.Set.StrengthController.handle

      assert expected == message
    end
  end

  describe "when provided with a short stength score and a modifier" do
    test "it stores the score" do
      expected = "#{name}'s strength has been set to #{stat} (#{modifier})"
      message = state(%{ text: text_short_modifier })
        |> GmBot.Controllers.Set.StrengthController.handle

      assert expected == message
    end
  end

  describe "when provided with a non number for the stat" do
    test "it informs the user" do
      expected = "Please provide only numbers in your strength score"
      message = state(%{ text: text_non_number })
        |> GmBot.Controllers.Set.StrengthController.handle

      assert expected == message
    end
  end

  describe "when provided with a non number for the modifier" do
    test "it informs the user" do
      expected = "Please provide only numbers in your strength score"
      message = state(%{ text: text_non_number_modifier })
        |> GmBot.Controllers.Set.StrengthController.handle

      assert expected == message
    end
  end
end
