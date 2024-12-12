defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "spechul_sort can sort based on rules" do
    rules = %{3=>[1], 2=>[4], 5=>[3, 2]}
    assert Day5.specul_sorted?([5,3,1,2,4], rules) == true
    assert Day5.specul_sorted?([5,3,2,1,4], rules) == true
    assert Day5.specul_sorted?([5,3,2,4,1], rules) == true

    assert Day5.specul_sorted?([5,1,3,2,4], rules) == false
    assert Day5.specul_sorted?([2,5,3,1,4], rules) == false
  end

  test "find_middle_value gets the middle values in list" do
    assert Day5.find_middle_value([5,3,1,2,4]) == 1
    assert Day5.find_middle_value([5,3,2,1,4]) == 2
    assert Day5.find_middle_value([5,1,3,2,4]) == 3
  end

  test "SpechulSort sorts based on rules" do
    rules = "3|1\n2|4\n5|3\n5|2"
    parsed_rules = Day5.parse_rules_to_edges(rules)
    assert SpechulSort.sort([5,1,3,2,4], parsed_rules) == [5,2,4,3,1]
    assert SpechulSort.sort([2,5,3,1,4], parsed_rules) == [5,2,4,3,1]
  end

  test "part1 integration" do
    {:ok, rules_content} = File.read("test/rules.txt")
    {:ok, data_content} = File.read("test/test_data.txt")

    rules = Day5.parse_rules(rules_content)
    data = Day5.parse_data(data_content)

    result = Enum.reduce(data, 0, fn data_page, acc ->
      if Day5.specul_sorted?(data_page, rules) do acc + Day5.find_middle_value(data_page) else acc end
    end)

    assert result == 143
  end

  test "part2 integration" do
    {:ok, rules_content} = File.read("test/rules.txt")
    {:ok, data_content} = File.read("test/test_data.txt")

    edges = Day5.parse_rules_to_edges(rules_content)
    rules = Day5.parse_rules(rules_content)
    data = Day5.parse_data(data_content)

    result = Enum.reduce(data, 0, fn data_page, acc ->
      is_sorted = Day5.specul_sorted?(data_page, rules)
      sorted = SpechulSort.sort(data_page, edges)
      if !is_sorted do acc + Day5.find_middle_value(sorted) else acc end
    end)

    assert result == 4884
  end
end
