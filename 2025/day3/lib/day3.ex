defmodule Day3 do
  @moduledoc """
  Uses a greedy stack-based algorithm to find the largest possible number
  """

  def max_joltage(battery_string, max_length) do
    batteries = String.graphemes(battery_string)
    to_remove = max(length(batteries) - max_length, 0)

    {stack, rem} =
      Enum.reduce(batteries, {[], to_remove}, fn battery, {stack, rem} ->
        {stack_after_pops, rem_after_pops} = pop_while_smaller(stack, battery, rem)
        {[battery | stack_after_pops], rem_after_pops}
      end)

    final_stack =
      if rem > 0 do
        Enum.drop(stack, rem)
      else
        stack
      end

    final_stack
    |> Enum.reverse()
    |> Enum.join()
    |> String.to_integer()
  end

  defp pop_while_smaller([top | rest] = _stack, d, rem) when rem > 0 and top < d do
    pop_while_smaller(rest, d, rem - 1)
  end

  defp pop_while_smaller(stack, _d, rem), do: {stack, rem}

  def part1(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(&max_joltage(&1, 2))
    |> Enum.sum()
  end

  def part2(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(&max_joltage(&1, 12))
    |> Enum.sum()
  end
end
