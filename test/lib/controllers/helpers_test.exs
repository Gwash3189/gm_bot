defmodule GmBot.Tests.Controllers.Helpers do
  use ExUnit.Case
  alias GmBot.Controllers.Helpers

  def state(text), do: %{
    parts: String.split(text, " "),
    text: "(#{text})"
  }

  describe "when there is a positive modifier in the parts list" do
    test "it retrieves it" do
        modifier_tuple = state("+1")
          |> Helpers.get_modifier

        assert elem(modifier_tuple, 0) == :ok
        assert elem(modifier_tuple, 1) == 1
    end
  end

  describe "when there is a negative modifier in the parts list" do
    test "it retrieves it" do
        modifier_tuple = state("-1")
          |> Helpers.get_modifier

        assert elem(modifier_tuple, 0) == :ok
        assert elem(modifier_tuple, 1) == -1
    end
  end

  describe "when there is a non-number modifier in the parts list" do
    test "safely tranforms it" do
        modifier_tuple = state("-A")
          |> Helpers.get_modifier

        assert elem(modifier_tuple, 0) == :error
        assert elem(modifier_tuple, 1) == :non_safe_int
    end
  end

  describe "when there is no modifier in the parts list" do
    test "returns an error" do
        modifier_tuple = state("none")
          |> Helpers.get_modifier

        assert elem(modifier_tuple, 0) == :error
        assert elem(modifier_tuple, 1) == :no_modifier
    end
  end

  describe "when getting stats value from text" do
    test "gets the stats value" do
      assert Helpers.get_stat_value(state("STR: 1")) == {:ok, 1}
    end
  end

  describe "when there are modifiers in the text" do
    test "it gets the stats value" do
      assert Helpers.get_stat_value(state("STR: 1 (+1)")) == {:ok, 1}
    end
  end

  describe "when there are modifiers in plain english" do
    test "it gets the stats value" do
      assert Helpers.get_stat_value(state("strength to 1 (+1)")) == {:ok, 1}
    end
  end

  describe "when there is a non number in the text" do
    test "it returns an error" do
      assert Helpers.get_stat_value(state("STR: Q (+1)")) == {:error, :non_safe_int}
    end
  end
end
