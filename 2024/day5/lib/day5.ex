defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  @doc """
  """
  def specul_sorted?(data, rule_map) do
    satisfied? =
      for i <- 1..length(data) - 1 do
        rule = Map.get(rule_map, Enum.at(data, i))
        {previous, _} = Enum.split(data, i)
        rule_satisfied?(previous, rule)
      end

    Enum.all?(satisfied?)
  end

  def find_middle_value(data) do
    Enum.at(data, div(length(data), 2))
  end

  def parse_rules(content) do
    content
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(fn val ->
      String.split(val, "|")
    end)
    |> Enum.flat_map(fn val -> val end)
    |> Enum.map(fn val -> String.to_integer(val) end)
    |> Enum.chunk_every(2) # Create pairs of [key, value]
    |> Enum.reduce(%{}, fn [key, value], acc ->
      Map.update(acc, key, [value], fn existing -> existing ++ [value] end)
    end)
  end

  def parse_rules_to_edges(content) do
    content
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(fn val ->
      String.split(val, "|")
    end)
    |> Enum.flat_map(fn val -> val end)
    |> Enum.map(fn val -> String.to_integer(val) end)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [val1, val2] ->
      Graph.Edge.new(val1, val2)
    end)
  end

  def parse_data(content) do
    String.split(content, ~r/\r?\n/, trim: true)
    |> Enum.map(fn line ->
      String.split(String.trim(line), ",")
    end)
    |> Enum.map(fn inner_list ->
      Enum.map(inner_list, &String.to_integer/1)  # Convert each string in the inner list to an integer
    end)
  end

  defp rule_satisfied?([], _) do true end
  defp rule_satisfied?(_, nil) do true end
  defp rule_satisfied?(list, rule) do
    !Enum.any?(rule, fn val -> Enum.member?(list, val) end)
  end
end

defmodule SpechulSort do

  def sort(list, edges) do
    only_used_edges = Enum.reject(edges, fn edge ->
      !Enum.member?(list, edge.v1) || !Enum.member?(list, edge.v2)
    end)
    graph = Graph.new
    |> Graph.add_vertices(list)
    |> Graph.add_edges(only_used_edges)

    Graph.topsort(graph)
  end
end
