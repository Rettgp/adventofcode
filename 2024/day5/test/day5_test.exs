defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "spechul_sort can sort based on rules" do
    rules = ["3|1", "2|4", "5|3", "5|2"]
    assert Day5.specul_sorted?([2,1,3,5,4], rules) == true
  end
end
