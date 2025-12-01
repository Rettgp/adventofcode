defmodule Day1 do
  @moduledoc """
  You could follow the instructions,
  but your recent required official North Pole secret entrance security training seminar
  taught you that the safe is actually a decoy.
  The actual password is the number of times the dial is left pointing at 0 after any rotation in the sequence.

  The dial starts at 50.
  """

  @doc """
  Parses a command string like "R16" or "L24" into a signed integer.
  Right ("R") is positive, left ("L") is negative.
  Returns the signed integer.
  """
  def parse_turn(<<direction::binary-size(1), num::binary>>) do
    case {direction, Integer.parse(num)} do
      {"R", {n, ""}} -> n
      {"L", {n, ""}} -> -n
      _ -> raise ArgumentError, "Invalid command string: #{direction <> num}"
    end
  end

  defp mod100(n), do: rem(rem(n, 100) + 100, 100)

  @spec count_zero_passes(integer(), integer()) :: non_neg_integer()
  defp count_zero_passes(_, 0), do: 0

  @spec count_zero_passes(integer(), integer()) :: non_neg_integer()
  defp count_zero_passes(current, move) do
    offset =
      if move >= 0,
        do: rem(100 - rem(current, 100), 100),
        else: rem(current, 100)

    first = if offset == 0, do: 100, else: offset

    if abs(move) < first do
      0
    else
      1 + div(abs(move) - first, 100)
    end
  end

  @doc """
  Rotates the dial from the current value according to the value change.
  Returns the new value of the dial.
  """
  @spec rotate_dial(integer(), integer()) :: {integer(), integer()}
  def rotate_dial(current_value, move) do
    zero_passes = count_zero_passes(current_value, move)
    new_value = mod100(current_value + move)
    {new_value, zero_passes}
  end

  @spec part1(binary()) :: non_neg_integer()
  def part1(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(&parse_turn/1)
    |> Enum.reduce({50, 0}, fn value_change, {current_value, zero_count} ->
      {new_value, _passed_zero} = rotate_dial(current_value, value_change)

      if new_value == 0 do
        {new_value, zero_count + 1}
      else
        {new_value, zero_count}
      end
    end)
    |> elem(1)
  end

  @spec part2(binary()) :: non_neg_integer()
  def part2(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(&parse_turn/1)
    |> Enum.reduce({50, 0}, fn value_change, {current_value, zero_count} ->
      {new_value, passed_zero} = rotate_dial(current_value, value_change)
      {new_value, zero_count + passed_zero}
    end)
    |> elem(1)
  end
end
