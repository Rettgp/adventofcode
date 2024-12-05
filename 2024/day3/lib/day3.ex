defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  @doc """
  """
  @spec find_mul(String.t()) :: list(String.t())
  def find_mul(input_string) do
    Regex.scan(~r/mul\(-?[0-9]{1,3},-?[0-9]{1,3}\)/, input_string)
    |> List.flatten()
  end

  @doc """
  """
  @spec mul(list(String.t())) :: integer()
  def mul(_mul_list) do
    # mul
    #   |> Enum.map(fn [a, b] ->
    #     Regex.scan(~r/mul\(-?[0-9]{1,3},-?[0-9]{1,3}\)/, input_string)
    #     Regex.scan(~r/mul\(-?[0-9]{1,3},-?[0-9]{1,3}\)/, input_string)
    #     a < b
    #   end)
    # |> List.flatten()
    0
  end
end
