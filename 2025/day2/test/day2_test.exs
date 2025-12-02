defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "has_duplicate_sequence" do
    assert Day2.has_duplicate_sequence("1") == false
    assert Day2.has_duplicate_sequence("333") == false
    assert Day2.has_duplicate_sequence("1234") == false
    assert Day2.has_duplicate_sequence("1123") == false
    assert Day2.has_duplicate_sequence("1231") == false
    assert Day2.has_duplicate_sequence("1212") == true
    assert Day2.has_duplicate_sequence("1234567890") == false
    assert Day2.has_duplicate_sequence("12345678901234567890") == true
    assert Day2.has_duplicate_sequence("11") == true
    assert Day2.has_duplicate_sequence("12") == false
    assert Day2.has_duplicate_sequence("12341234") == true
    assert Day2.has_duplicate_sequence("1188511882") == false
    assert Day2.has_duplicate_sequence("565656") == false
  end

  test "has_repeating_sequence" do
    assert Day2.has_repeating_sequence("1") == false
    assert Day2.has_repeating_sequence("333") == true
    assert Day2.has_repeating_sequence("4444") == true
    assert Day2.has_repeating_sequence("1234") == false
    assert Day2.has_repeating_sequence("1123") == false
    assert Day2.has_repeating_sequence("1231") == false
    assert Day2.has_repeating_sequence("1212") == true
    assert Day2.has_repeating_sequence("1234567890") == false
    assert Day2.has_repeating_sequence("11") == true
    assert Day2.has_repeating_sequence("12") == false
    assert Day2.has_repeating_sequence("1188511882") == false
    assert Day2.has_repeating_sequence("1188511885") == true
    assert Day2.has_repeating_sequence("565656") == true
    assert Day2.has_repeating_sequence("990888") == false
  end
end
