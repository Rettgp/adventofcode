defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  @doc """
  """
  def specul_sorted?(data, rules) do
    rule_map =
      rules
      |> Enum.map(fn [a, b] ->
        {a, b}
      end)
      |> Map.new

    IO.inspect(rule_map)

    false
  end
end
