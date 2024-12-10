defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "spechul_sort can sort based on rules" do
    rules = ["3|1", "2|4", "5|3", "5|2"]
    assert Enum.sort([2,1,3,5,4], Day5.specul_sort(rules)) === [5, 2, 3, 1, 4]
  end
end
