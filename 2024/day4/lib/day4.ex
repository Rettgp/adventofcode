defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  @doc """
  Hello world.

  ## Examples
  """
  def create_grid("") do {0, 0, []} end
  def create_grid(input) do
    String.split(input, ~r/\r?\n/, trim: true)
    |> Enum.map(fn element ->
      String.graphemes(String.upcase(element))
    end)
  end

  def count_word(search_term, word) do
    Regex.scan(~r/#{search_term}/, word)
    |> length()
  end

  def transpose(grid) do
    grid
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def count_in_rows(grid, search_term \\ "XMAS") do
    grid
    |> Enum.map(&Enum.join/1)
    |> Enum.map(fn row ->
        count_word(search_term, row) + count_word(String.reverse(search_term), row)
      end)
    |> Enum.sum()
  end

  def count_diagonals(grid, search_term \\ "XMAS") do
    get_diagonals(grid)
    |> Enum.map(&Enum.join/1)
    |> Enum.reduce(0, fn diagonal, acc ->
      acc + count_word(search_term, diagonal) + count_word(String.reverse(search_term), diagonal)
    end)
  end

  def get_diagonals(grid) do
    height = length(grid)
    width = length(hd(grid))

    left_downward_right_diagonals = for offset <- -(height - 1)..(width - 1) do
      for row <- 0..(height - 1),
          col = row + offset,
          col >= 0 and col < width,
          do: Enum.at(Enum.at(grid, row), col)
      end
    |> Enum.reject(&(&1 == nil))

    left_downward_left_diagonals = for offset <- 0..(height + width - 2) do
      for row <- 0..(height - 1),
          col = offset - row,
          col >= 0 and col < width,
          do: Enum.at(Enum.at(grid, row), col)
      end
    |> Enum.reject(&(&1 == nil))

    left_downward_left_diagonals ++ left_downward_right_diagonals
  end

  def count_x_dash_mas(grid) do
    height = length(grid)
    width = length(hd(grid))
    for row <- 1..(height - 2) do
      for col <- 1..(width - 2) do
        if Enum.at(Enum.at(grid, row), col) === "A" do
          Enum.at(Enum.at(grid, row - 1), col - 1)
          <> Enum.at(Enum.at(grid, row - 1), col + 1)
          <> Enum.at(Enum.at(grid, row + 1), col - 1)
          <> Enum.at(Enum.at(grid, row + 1), col + 1)
        else
          ""
        end
      end
    end
    |> Enum.flat_map(fn x -> x end)
    |> Enum.reduce(0, fn x, acc ->
      acc + count_word("MSMS", x) +
        count_word("SMSM", x) +
        count_word("SSMM", x) +
        count_word("MMSS", x)
    end)
  end
end
