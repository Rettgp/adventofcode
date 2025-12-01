defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "parse_turn parses left as negative" do
    assert Day1.parse_turn("L2") == -2
    assert Day1.parse_turn("L150") == -150
    assert Day1.parse_turn("L0") == 0
  end

  test "parse_turn parses right as positive" do
    assert Day1.parse_turn("R2") == 2
    assert Day1.parse_turn("R150") == 150
    assert Day1.parse_turn("R0") == 0
  end

  test "rotate_dial handles negative numbers" do
    assert Day1.rotate_dial(50, -12) == {38, 0}
  end

  test "rotate_dial handles positive numbers" do
    assert Day1.rotate_dial(50, 25) == {75, 0}
  end

  test "rotate_dial rolls over at 100" do
    assert Day1.rotate_dial(0, -1) == {99, 0}
    assert Day1.rotate_dial(0, 1) == {1, 0}
    assert Day1.rotate_dial(50, 50) == {0, 1}
    assert Day1.rotate_dial(50, 212) == {62, 2}
    assert Day1.rotate_dial(0, 250) == {50, 2}
    assert Day1.rotate_dial(0, 200) == {0, 2}
    assert Day1.rotate_dial(0, 1000) == {0, 10}
    assert Day1.rotate_dial(50, -50) == {0, 1}
    assert Day1.rotate_dial(50, -75) == {75, 1}
    assert Day1.rotate_dial(50, -250) == {0, 3}
    assert Day1.rotate_dial(0, -250) == {50, 2}
    assert Day1.rotate_dial(0, -1000) == {0, 10}
    assert Day1.rotate_dial(1, -201) == {0, 3}
  end

  test "part2 rotate_dial" do
    {final, total_zeros} =
      [-68, -30, 48, -5, 60, -55, -1, -99, 14, -82]
      |> Enum.reduce({50, 0}, fn move, {pos, zeros} ->
        {new_pos, new_zeros} = Day1.rotate_dial(pos, move)
        {new_pos, zeros + new_zeros}
      end)

    assert {final, total_zeros} == {32, 6}
  end
end
