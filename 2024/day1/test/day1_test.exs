defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "generate_lists creates two separate lists from input" do
    assert Day1.generate_lists("1 2") === {[1], [2]}
  end

  test "generate_lists creates two separate lists from multiple lines of input" do
    assert Day1.generate_lists("""
    1 2
    3 4
    """) === {[1, 3], [2, 4]}
  end

  test "generate_lists handles variable amount of whitespace" do
    assert Day1.generate_lists("""
    1   2
    3     4
    """) === {[1, 3], [2, 4]}
  end

  test "generate_lists returns empty lists for empty string" do
    assert Day1.generate_lists("") === {[], []}
  end

  test "find_total_distance returns 0 if empty lists" do
    assert Day1.generate_lists("") |> Day1.find_total_distance() === 0
  end

  test "find_total_distance returns absolute difference between lists" do
    assert Day1.generate_lists("""
    2 1
    """) |> Day1.find_total_distance() === 1

    assert Day1.generate_lists("""
    1 2
    """) |> Day1.find_total_distance() === 1
  end

  test "find_total_distance returns total distance" do
    assert Day1.generate_lists("""
    2 1
    4 4
    3 2
    1 3
    """) |> Day1.find_total_distance() === 0
  end

  test "find_total_distance integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        assert Day1.generate_lists(content)
          |> Day1.find_total_distance() === 3714264

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end

  test "find_similarity_score returns 0 for empty lists" do
    assert Day1.generate_lists("") |> Day1.find_similarity_score() === 0
  end

  test "find_similarity_score returns 0 if no similarities" do
    assert Day1.generate_lists("""
    1 4
    2 5
    3 6
    """) |> Day1.find_similarity_score() === 0
  end

  test "find_similarity_score returns sum of similarity for first list" do
    assert Day1.generate_lists("""
    3 4
    4 3
    2 5
    1 3
    3 9
    3 3
    """) |> Day1.find_similarity_score() === 31
  end

  test "find_similarity_score integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        assert Day1.generate_lists(content)
          |> Day1.find_similarity_score() === 18805872

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end
end
