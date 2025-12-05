defmodule Day5 do
  @moduledoc """
  Use the power of Elixir ranges and a merge algorithm to conquer my foes
  """

  def populate_fresh_ingredients(ingredient_ranges) do
    Enum.map(ingredient_ranges, fn range ->
      [a, b] =
        range
        |> String.split("-", trim: true)
        |> Enum.map(&String.to_integer/1)

      a..b
    end)
    |> List.flatten()
    |> Enum.uniq()
  end

  def is_fresh?(ingredient, fresh_ingredients) do
    Enum.any?(fresh_ingredients, fn range ->
      ingredient in range
    end)
  end

  def merge_fresh_ingredients(fresh_ingredients) do
    fresh_ingredients
    |> Enum.sort_by(fn range ->
      range_start.._//_ = range
      range_start
    end)
    |> Enum.reduce([], fn range, acc ->
      range_start..range_end//_ = range

      case acc do
        [] ->
          [range]

        [prev_start..prev_end//_ | tail] ->
          if range_start <= prev_end + 1 do
            [prev_start..max(prev_end, range_end) | tail]
          else
            [range | acc]
          end
      end
    end)
  end

  def run(file_path) do
    groups =
      File.read!(file_path)
      |> String.split(~r/\R{2,}/, trim: true)
      |> Enum.map(fn block ->
        block
        |> String.split(~r/\R+/, trim: true)
      end)

    [list1, list2] = groups
    fresh_ingredients = populate_fresh_ingredients(list1)
    available_ingredients = Enum.map(list2, &String.to_integer/1)

    Enum.filter(available_ingredients, fn ingredient ->
      is_fresh?(ingredient, fresh_ingredients)
    end)
    |> Enum.count()
    |> IO.inspect(label: "Number of Fresh Ingredients in Part 1")

    merge_fresh_ingredients(fresh_ingredients)
    |> Enum.reduce(0, fn r, acc ->
      acc + Range.size(r)
    end)
    |> IO.inspect(label: "Total Fresh Ingredients for Part 2")

    "Done"
  end
end
