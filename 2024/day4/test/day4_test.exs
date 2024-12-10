defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "Input string is converted into a char grid" do
    grid = Day4.create_grid("XMAS\nXMSA\nXAMS")
    assert Enum.at(grid, 0) == ["X", "M", "A", "S"]
    assert Enum.at(grid, 1) == ["X", "M", "S", "A"]
    assert Enum.at(grid, 2) == ["X", "A", "M", "S"]
  end

  test "count_word counts the number of times a word occurs" do
    assert Day4.count_word("XMAS", "XMASXMASsdfXMAS") == 3
  end

  test "count_in_rows finds horizontal matches" do
    grid = [
      [".", ".", "X", ".", ".", "."],
      [".", "S", "A", "M", "X", "."],
      [".", "A", ".", ".", "A", "."],
      ["X", "M", "A", "S", ".", "S"],
      [".", "X", ".", ".", ".", "."],
    ]
    assert Day4.count_in_rows(grid) == 2
  end

  test "count_in_rows finds multiple matches in a row" do
    grid = [
      ["X", "M", "A", "S", "X", "M", "A", "S"],
    ]
    assert Day4.count_in_rows(grid) == 2
  end

  test "count_in_rows finds vertical matches after transpose" do
    grid = [
      [".", ".", "X", ".", ".", "."],
      [".", "S", "A", "M", "X", "."],
      [".", "A", ".", ".", "A", "."],
      ["X", "M", "A", "S", ".", "S"],
      [".", "X", ".", ".", ".", "."],
    ]
    assert Day4.transpose(grid)
    |> Day4.count_in_rows("XMAS") == 1
  end

  test "count_in_rows finds diagonal matches" do
    grid = [
      [".", ".", "X", ".", ".", "."],
      [".", "S", "A", "M", "X", "S"],
      [".", "A", ".", ".", "A", "."],
      ["X", "M", "A", "M", ".", "S"],
      [".", "X", "X", ".", ".", "."],
    ]
    assert Day4.count_diagonals(grid) == 2
  end

  test "count_x-mas finds matches" do
    grid = [
      [".", "M", ".", "S", ".", ".", ".", ".", ".", "."],
      [".", ".", "A", ".", ".", "M", "S", "M", "S", "."],
      [".", "M", ".", "S", ".", "M", "A", "A", ".", "."],
      [".", ".", "A", ".", "A", "S", "M", "S", "M", "."],
      [".", "M", ".", "S", ".", "M", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      ["S", ".", "S", ".", "S", ".", "S", ".", "S", "."],
      [".", "A", ".", "A", ".", "A", ".", "A", ".", "."],
      ["M", ".", "M", ".", "M", ".", "M", ".", "M", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
    ]
    assert Day4.count_x_dash_mas(grid) == 9
  end

  test "part1 integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        grid = Day4.create_grid(content)
        horizontal = Day4.count_in_rows(grid)
        vertical = Day4.transpose(grid)
        |> Day4.count_in_rows()
        diagonal = Day4.count_diagonals(grid)
        assert horizontal + vertical + diagonal == 2336

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end

  test "part2 integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        grid = Day4.create_grid(content)
        assert Day4.count_x_dash_mas(grid) == 1831

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end
end
