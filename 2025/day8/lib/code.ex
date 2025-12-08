defmodule Day8 do
  @moduledoc """
  Make 10 shortest connections.
  Group connected junctions to a list/container.
  Multiply together the 3 largest groups
  """

  def distance({x1, y1, z1}, {x2, y2, z2}) do
    :math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2)
  end

  def find(parent_map, point) do
    case Map.get(parent_map, point, point) do
      ^point ->
        {point, parent_map}

      parent ->
        {root, parent_map} = find(parent_map, parent)
        {root, Map.put(parent_map, point, root)}
    end
  end

  def union(parent_map, a, b) do
    {root_a, parent_map} = find(parent_map, a)
    {root_b, parent_map} = find(parent_map, b)

    if root_a == root_b do
      {false, parent_map}
    else
      {true, Map.put(parent_map, root_a, root_b)}
    end
  end

  def run(file_path) do
    file_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(fn coord ->
      String.split(coord, ",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.with_index()
    |> then(fn indexed ->
      for {coord1, index1} <- indexed,
          {coord2, index2} <- indexed,
          index1 < index2,
          do: {distance(coord1, coord2), coord1, coord2}
    end)
    |> Enum.sort_by(fn {distance, _, _} -> distance end)
    |> Enum.take(1000)
    |> Enum.reduce([], fn {_, a, b}, groups ->
      {intersecting, non_intersecting} =
        Enum.split_with(groups, fn group ->
          MapSet.member?(group, a) or MapSet.member?(group, b)
        end)

      merged_group =
        intersecting
        |> Enum.reduce(MapSet.new([a, b]), fn group, acc ->
          MapSet.union(group, acc)
        end)

      [merged_group | non_intersecting]
    end)
    |> Enum.sort_by(&MapSet.size/1, :desc)
    |> Enum.take(3)
    |> Enum.reduce([], fn group, acc ->
      [MapSet.size(group) | acc]
    end)
    |> Enum.uniq()
    |> Enum.product()
    |> IO.inspect(label: "Result P1")
  end

  def run_p2(file_path) do
    points =
      file_path
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(fn coord ->
        String.split(coord, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    pairs =
      points
      |> Enum.with_index()
      |> then(fn indexed ->
        for {coord1, index1} <- indexed,
            {coord2, index2} <- indexed,
            index1 < index2,
            do: {distance(coord1, coord2), coord1, coord2}
      end)
      |> Enum.sort_by(fn {distance, _, _} -> distance end)

    {_, last_pair, _} =
      Enum.reduce_while(pairs, {%{}, nil, length(points)}, fn {_distance, a, b}, {pm, last, count} ->
        {merged, pm} = union(pm, a, b)

        if merged do
          roots =
            points
            |> Enum.map(&elem(find(pm, &1), 0))
            |> Enum.uniq()

          if length(roots) == 1 do
            {:halt, {pm, {a, b}, 1}}
          else
            {:cont, {pm, {a, b}, length(roots)}}
          end
        else
          {:cont, {pm, last, count}}
        end
      end)

    last_pair
    |> Tuple.to_list()
    |> Enum.reduce(1, fn point, acc ->
      acc * elem(point, 0)
    end)
    |> IO.inspect(label: "Result P2")
  end
end
