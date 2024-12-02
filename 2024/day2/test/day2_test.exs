defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "empty report are safe" do
    assert Day2.Report.safe?(%Day2.Report{values: []}, 0) === true
  end

  test "single value report is safe" do
    assert Day2.Report.safe?(%Day2.Report{values: [1]}, 0) === true
  end

  test "report is safe if they are all increasing" do
    assert Day2.Report.safe?(%Day2.Report{values: [1, 2, 3, 4, 5]}, 0) === true
  end

  test "report is safe if they are all decreasing" do
    assert Day2.Report.safe?(%Day2.Report{values: [5, 4, 3, 2, 1]}, 0) === true
  end

  test "report is not safe if there is a repeating adjacent value" do
    assert Day2.Report.safe?(%Day2.Report{values: [5, 4, 3, 3, 2, 1]}, 0) === false
  end

  test "report is not safe if adjacent value exceeds 3" do
    assert Day2.Report.safe?(%Day2.Report{values: [8, 4, 3, 2, 1,]}, 0) === false
  end

  test "report is not safe if it does not strictly increase/decrease" do
    assert Day2.Report.safe?(%Day2.Report{values: [5, 4, 1, 2, 3]}, 0) === false
  end

  test "report is safe with dampening with a single unsafe inc/dec level" do
    assert Day2.Report.safe?(%Day2.Report{values: [5, 1, 2, 3]}, 1) === true
  end

  test "report is safe with dampening with a single unsafe >3 level" do
    assert Day2.Report.safe?(%Day2.Report{values: [1, 5, 3]}, 1) === true
  end

  test "report is not safe with dampening with a multiple unsafe levels" do
    assert Day2.Report.safe?(%Day2.Report{values: [5, 4, 1, 2, 3]}, 1) === false
  end

  test "create_report creates empty reports if empty string" do
    assert Day2.create_reports("") === []
  end

  test "create_report creates 1 report for a single row" do
    assert Day2.create_reports("1 2 3 4 5") ===
        [%Day2.Report{values: [1, 2, 3, 4, 5]}]
  end

  test "create_report creates multiple reports for a multiple rows" do
    assert Day2.create_reports("""
      1 2 3 4 5
      5 4 3 2 1
      0 0 0 0 0
    """) === [
      %Day2.Report{values: [1, 2, 3, 4, 5]},
      %Day2.Report{values: [5, 4, 3, 2, 1]},
      %Day2.Report{values: [0, 0, 0, 0, 0]}
    ]
  end

  test "day2 part 1 integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        assert Day2.create_reports(content)
          |> Enum.count(fn report -> Day2.Report.safe?(report, 0) end) == 242

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end

  test "day2 part 2 integration" do
    case File.read("test/test_data.txt") do
      {:ok, content} ->
        assert Day2.create_reports(content)
          |> Enum.count(fn report -> Day2.Report.safe?(report, 1) end) == 311

      {:error, reason} ->
        raise "Error reading file: #{reason}"
    end
  end
end
