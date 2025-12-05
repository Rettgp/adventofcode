defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "populate_fresh_ingredients" do
    input = ["1-3", "5-7", "10-12"]
    assert Day5.populate_fresh_ingredients(input) == [1..3, 5..7, 10..12]
  end
end
