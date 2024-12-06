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

  test "find_mult returns dont found" do
    mul = Day3.find_mul("don't()mul(1,2)don't()")
    assert length(mul) == 3
    assert Enum.at(mul, 0) === Day3.block
    assert Enum.at(mul, 1) === "mul(1,2)"
    assert Enum.at(mul, 2) === Day3.block
  end

  test "find_mult returns do found" do
    mul = Day3.find_mul("do()mul(1,2)do()")
    assert length(mul) == 3
    assert Enum.at(mul, 0) === Day3.run
    assert Enum.at(mul, 1) === "mul(1,2)"
    assert Enum.at(mul, 2) === Day3.run
  end

  test "mul calculates multiply directive" do
    assert Day3.mul(["mul(1,2)"]) === 2
  end

  test "mul calculates multiply directive with three digits" do
    assert Day3.mul(["mul(100,200)"]) === 20000
  end

  test "mul calculates negative multiply directives" do
    assert Day3.mul(["mul(-1,2)"]) === -2
    assert Day3.mul(["mul(-1,-2)"]) === 2
    assert Day3.mul(["mul(1,-2)"]) === -2
  end

  test "mul calculates sum of all multiply directives" do
    assert Day3.mul(["mul(1,2)", "mul(2,3)", "mul(3,4)", "mul(4,5)"]) === 40
  end

  test "mul ignores anything after a block" do
    assert Day3.mul(["mul(1,2)", Day3.block, "mul(2,3)"]) === 2
  end

  test "mul resumes when a run occurs after a block" do
    assert Day3.mul(["mul(1,2)", Day3.block, "mul(2,3)", Day3.run, "mul(3,4)"]) === 14
  end

  test "part2 integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        assert Day3.find_mul(content)
        |> Day3.mul() === 74838033

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end

end
