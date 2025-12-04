defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "can_access_roll?" do
    grid =
      Day4.create_roll_grid("""
      ..@@.@@@@.
      @@@.@.@.@@
      @@@@@.@.@@
      """)

    # Correct access grid:
    # ..xx.xx@x.
    # x@@.@.@.@@
    # x@@@x.x.xx

    assert Day4.access_roll?(grid, {0, 2}) == true
    assert Day4.access_roll?(grid, {0, 3}) == true
    assert Day4.access_roll?(grid, {0, 5}) == true
    assert Day4.access_roll?(grid, {0, 6}) == true
    assert Day4.access_roll?(grid, {0, 7}) == false
    assert Day4.access_roll?(grid, {0, 8}) == true
    assert Day4.access_roll?(grid, {1, 0}) == true
    assert Day4.access_roll?(grid, {1, 1}) == false
    assert Day4.access_roll?(grid, {1, 2}) == false
    assert Day4.access_roll?(grid, {1, 4}) == false
    assert Day4.access_roll?(grid, {1, 6}) == false
    assert Day4.access_roll?(grid, {1, 8}) == false
    assert Day4.access_roll?(grid, {1, 9}) == false
    assert Day4.access_roll?(grid, {2, 0}) == true
    assert Day4.access_roll?(grid, {2, 1}) == false
    assert Day4.access_roll?(grid, {2, 2}) == false
    assert Day4.access_roll?(grid, {2, 3}) == false
    assert Day4.access_roll?(grid, {2, 4}) == true
    assert Day4.access_roll?(grid, {2, 6}) == true
    assert Day4.access_roll?(grid, {2, 8}) == true
    assert Day4.access_roll?(grid, {2, 9}) == true
  end
end
