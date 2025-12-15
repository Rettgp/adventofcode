defmodule Day9 do
  @moduledoc """
  """

  def run_part1(file_path) do
    points =
      file_path
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(fn coord_string ->
        String.split(coord_string, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    largest_rectangle =
      points
      |> Enum.flat_map(fn {x1, y1} ->
        for {x2, y2} <- points,
            x1 != x2 or y1 != y2 do
          width = abs(x2 - x1) + 1
          height = abs(y2 - y1) + 1
          area = width * height
          %{area: area, diag: [{x1, y1}, {x2, y2}]}
        end
      end)
      |> Enum.max_by(& &1.area)

    largest_rectangle.area
  end

  defp rect_bounds({x1, y1}, {x2, y2}) do
    {min(x1, x2), min(y1, y2), max(x1, x2), max(y1, y2)}
  end

  defp intersects_rect?({{x1, y1}, {x2, y2}}, {rx1, ry1, rx2, ry2}) do
    cond do
      Enum.max([x1, x2]) <= rx1 -> false
      Enum.min([x1, x2]) >= rx2 -> false
      Enum.max([y1, y2]) <= ry1 -> false
      Enum.min([y1, y2]) >= ry2 -> false
      true -> true
    end
  end

  defp polygon_edges(points) do
    pts = points ++ [hd(points)]

    pts
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> {a, b} end)
  end

  defp valid_rectangle?({p1, p2}, edges) do
    bounds = rect_bounds(p1, p2)
    Enum.all?(edges, fn edge -> not intersects_rect?(edge, bounds) end)
  end

  def run_part2(file_path) do
    points =
      file_path
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(fn coord_string ->
        [x, y] = String.split(coord_string, ",")
        {String.to_integer(x), String.to_integer(y)}
      end)

    edges = polygon_edges(points)

    points
    |> Enum.with_index()
    |> Enum.flat_map(fn {p1, i} ->
      points
      |> Enum.drop(i + 1)
      |> Enum.map(fn p2 -> {p1, p2} end)
    end)
    |> Enum.reduce(0, fn pair, max_area ->
      if valid_rectangle?(pair, edges) do
        {x1, y1} = elem(pair, 0)
        {x2, y2} = elem(pair, 1)
        area = (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
        max(max_area, area)
      else
        max_area
      end
    end)
  end
end
