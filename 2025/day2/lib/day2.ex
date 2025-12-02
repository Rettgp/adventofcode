defmodule Day2 do
  @moduledoc """
  Your job is to find all of the invalid IDs that appear in the given ranges.

  In the above example:
  11-22 has two invalid IDs, 11 and 22.
  95-115 has one invalid ID, 99.
  998-1012 has one invalid ID, 1010.
  1188511880-1188511890 has one invalid ID, 1188511885.
  222220-222224 has one invalid ID, 222222.
  1698522-1698528 contains no invalid IDs.
  446443-446449 has one invalid ID, 446446.
  38593856-38593862 has one invalid ID, 38593859.
  The rest of the ranges contain no invalid IDs.

  Adding up all the invalid IDs in this example produces 1227775554.
  """

  def has_duplicate_sequence(str) when is_binary(str) do
    graphemes = String.graphemes(str)
    has_duplicate_sequence_graphemes(graphemes)
  end

  def has_repeating_sequence(str) when is_binary(str) do
    graphemes = String.graphemes(str)
    has_repeating_sequence_graphemes(graphemes)
  end

  def starts_with_zero(str) when is_binary(str) do
    String.starts_with?(str, "0")
  end

  defp has_duplicate_sequence_graphemes(graphemes) when length(graphemes) <= 1, do: false
  defp has_duplicate_sequence_graphemes(graphemes) when rem(length(graphemes), 2) != 0, do: false

  defp has_duplicate_sequence_graphemes(graphemes) do
    len = length(graphemes)
    half = div(len, 2)
    first_half = Enum.slice(graphemes, 0, half)
    second_half = Enum.slice(graphemes, half, half)
    first_half == second_half
  end

  defp has_repeating_sequence_graphemes(graphemes) when length(graphemes) < 2, do: false

  defp has_repeating_sequence_graphemes(graphemes) do
    len = length(graphemes)

    1..div(len, 2)
    |> Enum.any?(fn l ->
      rem(len, l) == 0 and
        div(len, l) >= 2 and
        Enum.chunk_every(graphemes, l)
        |> Enum.uniq()
        |> length() == 1
    end)
  end

  def part1(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/,/, trim: true)
    |> Enum.flat_map(fn range_str ->
      case String.split(range_str, "-") do
        [start_s, end_s] ->
          {start_n, ""} = Integer.parse(start_s)
          {end_n, ""} = Integer.parse(end_s)
          Enum.to_list(start_n..end_n)

        _ ->
          []
      end
    end)
    |> Enum.filter(fn n ->
      n_str = Integer.to_string(n)
      has_duplicate_sequence(n_str)
    end)
    |> Enum.sum()
  end

  def part2(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/,/, trim: true)
    |> Enum.flat_map(fn range_str ->
      case String.split(range_str, "-") do
        [start_s, end_s] ->
          {start_n, ""} = Integer.parse(start_s)
          {end_n, ""} = Integer.parse(end_s)
          Enum.to_list(start_n..end_n)

        _ ->
          []
      end
    end)
    |> Enum.filter(fn n ->
      n_str = Integer.to_string(n)
      has_repeating_sequence(n_str) or starts_with_zero(n_str)
    end)
    |> tap(&IO.inspect(&1, label: "Numbers with duplicate sequences"))
    |> Enum.sum()
  end
end
