defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """
  @block "don't()"
  @run "do()"
  defmacro block, do: @block
  defmacro run, do: @run

  @doc """
  """
  @spec find_mul(String.t()) :: list(String.t())
  def find_mul(input_string) do
    Regex.scan(~r/do\(\)|don\'t\(\)|mul\(-?[0-9]{1,3},-?[0-9]{1,3}\)/, input_string)
    |> List.flatten()
  end

  @doc """
  """
  @spec mul(list(String.t())) :: integer()
  def mul(mul_list) do
    mul_list
    |> Enum.reduce({[], false}, fn
        @block, {acc, _} -> {acc, true}
        @run, {acc, true} -> {acc, false}
        elem, {acc, true} -> {acc, true}
        elem, {acc, false} -> {acc ++ [elem], false}
      end)
    |> elem(0) # Extract the accumulated list
    |> Enum.map(fn mul_string ->
      Regex.scan(~r/-?[0-9]{1,3}/, mul_string)
    end)
    |> List.flatten()
    |> Enum.map(fn element -> String.to_integer(element) end)
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end
end
