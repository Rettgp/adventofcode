defmodule Day4 do
  @moduledoc """
  Uses slight brute force to iterate on the grid
  until there are no more rolls to remove
  """

  def create_roll_grid(input_string) do
    input_string
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(fn row_string ->
      String.graphemes(row_string)
    end)
  end

  def has_roll?(grid, {row, col}) do
    num_rows = length(grid)

    if row < 0 || row >= num_rows do
      false
    else
      row_data = Enum.at(grid, row)

      if is_nil(row_data) || col < 0 || col >= length(row_data) do
        false
      else
        Enum.at(row_data, col) == "@"
      end
    end
  end

  def access_roll?(grid, {row_idx, col_idx}) do
    if !has_roll?(grid, {row_idx, col_idx}) do
      false
    else
      adjacent_positions = [
        {row_idx - 1, col_idx},
        {row_idx + 1, col_idx},
        {row_idx, col_idx - 1},
        {row_idx, col_idx + 1},
        {row_idx - 1, col_idx - 1},
        {row_idx - 1, col_idx + 1},
        {row_idx + 1, col_idx - 1},
        {row_idx + 1, col_idx + 1}
      ]

      num_adjacent_with_rolls =
        Enum.count(adjacent_positions, fn {r, c} -> has_roll?(grid, {r, c}) end)

      num_adjacent_with_rolls < 4
    end
  end

  def find_total_number_of_rolls(grid) do
    grid
    |> Enum.with_index()
    |> Enum.reduce({[], 0}, fn {row, row_idx}, {row_outer, acc} ->
      {modified_row, row_total_rolls} =
        row
        |> Enum.with_index()
        |> Enum.reduce({[], 0}, fn {element, col_idx}, {row_inner, acc2} ->
          if access_roll?(grid, {row_idx, col_idx}) do
            {row_inner ++ ["x"], acc2 + 1}
          else
            {row_inner ++ [element], acc2}
          end
        end)

      {row_outer ++ [modified_row], acc + row_total_rolls}
    end)
  end

  def iterate(grid, previous_total) do
    {new_grid, new_total} = find_total_number_of_rolls(grid)
    total = new_total + previous_total

    if new_total == 0 do
      total
    else
      iterate(new_grid, total)
    end
  end

  def part1(file_path) do
    file_path
    |> File.read!()
    |> create_roll_grid()
    |> find_total_number_of_rolls()
    |> elem(1)
  end

  def part2(file_path) do
    file_path
    |> File.read!()
    |> create_roll_grid()
    |> iterate(0)
  end
end
