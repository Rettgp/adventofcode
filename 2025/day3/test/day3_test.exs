defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "find_largest_joltage" do
    assert Day3.max_joltage("987654321111111", 2) == 98
    assert Day3.max_joltage("811111111111119", 2) == 89
    assert Day3.max_joltage("234234234234278", 2) == 78
    assert Day3.max_joltage("818181911112111", 2) == 92
  end

  test "find_largest_joltage 12 number" do
    assert Day3.max_joltage("987654321111111", 12) == 987_654_321_111
    assert Day3.max_joltage("811111111111119", 12) == 811_111_111_119
    assert Day3.max_joltage("234234234234278", 12) == 434_234_234_278
    assert Day3.max_joltage("818181911112111", 12) == 888_911_112_111
  end
end
