defmodule Day1 do
  @moduledoc """
  Generate two sorted lists from input and then get the
  sequentially total distance between the two lists

  Ex.
  1 3
  4 2
  2 5

  Sorted...
  1 2 -> Difference 1
  2 3 -> Difference 1
  4 5 -> Difference 1

  Total Distance: 3
  """

  @doc """
    This assumes a balanced list of pairs
  """
  def generate_lists(input_string) do
    String.split(input_string, ~r/\r?\n/, trim: true)
    |> Enum.map(fn str ->
      [num1, num2] = String.split(str, ~r/\s+/)
      {String.to_integer(num1), String.to_integer(num2)}
    end)
    |> Enum.unzip()
  end

  @doc """
  """
  def find_total_distance({list1, list2}) do
    Enum.zip(Enum.sort(list1), Enum.sort(list2))
      |> Enum.map(fn {num1, num2} ->
        abs(num1 - num2)
      end)
      |> Enum.sum()
  end

  @doc """
  """
  def find_similarity_score({[], _list2}), do: 0
  def find_similarity_score({list1, list2}) do
    Enum.reduce(list1, 0, fn val1, accumulator ->
      accumulator + val1 * Enum.count(list2, fn val2 -> val2 === val1 end)
    end)
  end
end
