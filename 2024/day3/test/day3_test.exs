defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "find_mult return zero with empty string" do
    assert length(Day3.find_mul("")) == 0
  end

  test "find_mult return zero with malformed input" do
    assert length(Day3.find_mul("ul(1,2)")) == 0
    assert length(Day3.find_mul("mul(--1,2)")) == 0
    assert length(Day3.find_mul("mul(*1,2*)")) == 0
    assert length(Day3.find_mul("(1,2)")) == 0
    assert length(Day3.find_mul("mul( 1, 2)")) == 0
    assert length(Day3.find_mul("mul(1, 2 )")) == 0
    assert length(Day3.find_mul("mul( 1, 2 )")) == 0
  end

  test "find_mult returns all mults found" do
    mul1 = Day3.find_mul("mul(1,2)")
    assert length(mul1) == 1
    assert Enum.at(mul1, 0) === "mul(1,2)"

    mul2 = Day3.find_mul("mul(1,2)mul(2,1)")
    assert length(mul2) == 2
    assert Enum.at(mul2, 0) === "mul(1,2)"
    assert Enum.at(mul2, 1) === "mul(2,1)"

    mul3 = Day3.find_mul("mul(2,1)mul(0,0)mul(-1,3)")
    assert length(mul3) == 3
    assert Enum.at(mul3, 0) === "mul(2,1)"
    assert Enum.at(mul3, 1) === "mul(0,0)"
    assert Enum.at(mul3, 2) === "mul(-1,3)"
  end

  test "mul calculates each multiply directive" do
    assert Day3.mul(["mul(1,2)"]) === 2
  end
end
