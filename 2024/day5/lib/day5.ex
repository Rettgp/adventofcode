defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  @doc """
  """
  def specul_sort(rules) do
    pair_rules = Enum.map(rules, fn rule ->
      List.to_tuple(String.split(rule, "|") |> Enum.map(&String.to_integer/1))
    end)
    IO.inspect(pair_rules)

    fn a, b ->
      IO.inspect({a, b})
      !Enum.find(pair_rules, fn x -> x == {b, a} end)
    end
  end
end
