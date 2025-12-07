defmodule Day7 do
  @moduledoc """
  """
  defp add_beam(acc, _r, c, width) when c < 0 or c >= width, do: acc
  defp add_beam(acc, r, c, _width), do: MapSet.put(acc, {r + 1, c})

  def count_splits(grid) do
    height = length(grid)
    width = length(List.first(grid))
    {s_row, s_col} = find_start(grid)

    beams = MapSet.new([{s_row + 1, s_col}])
    simulate(grid, width, height, beams, 0)
  end

  defp find_start(rows) do
    Enum.with_index(rows)
    |> Enum.find_value(fn {row, r} ->
      case Enum.find_index(row, &(&1 == "S")) do
        nil -> false
        c -> {r, c}
      end
    end)
  end

  defp simulate(_rows, _width, _height, beams, splits) when beams == %MapSet{} do
    splits
  end

  defp simulate(rows, width, height, beams, splits) do
    {next_beams, new_splits} =
      Enum.reduce(beams, {MapSet.new(), splits}, fn {r, c}, {acc, count} ->
        cond do
          r >= height ->
            {acc, count}

          rows |> Enum.at(r) |> Enum.at(c) == "^" ->
            acc
            |> add_beam(r, c - 1, width)
            |> add_beam(r, c + 1, width)
            |> then(&{&1, count + 1})

          true ->
            {MapSet.put(acc, {r + 1, c}), count}
        end
      end)

    simulate(rows, width, height, next_beams, new_splits)
  end

  def count_timelines(grid) do
    {start_row, start_col} = find_start(grid)
    {total_paths, _memo} = traverse(grid, start_row + 1, start_col, %{})
    total_paths
  end

  defp traverse(grid, row, col, memo) do
    key = {row, col}

    # Check memo
    if Map.has_key?(memo, key) do
      {memo[key], memo}
    else
      {paths, memo} =
        if row >= length(grid) do
          # Always return a tuple
          {1, memo}
        else
          case Enum.at(Enum.at(grid, row), col) do
            "^" ->
              {left_paths, memo} =
                if col > 0 do
                  traverse(grid, row + 1, col - 1, memo)
                else
                  {0, memo}
                end

              {right_paths, memo} =
                if col < length(Enum.at(grid, row)) - 1 do
                  traverse(grid, row + 1, col + 1, memo)
                else
                  {0, memo}
                end

              {left_paths + right_paths, memo}

            "." ->
              traverse(grid, row + 1, col, memo)

            _ ->
              {0, memo}
          end
        end

      {paths, Map.put(memo, key, paths)}
    end
  end

  def run(file_path) do
    file_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
    |> count_splits()
  end

  def run_p2(file_path) do
    file_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
    |> count_timelines()
  end
end
