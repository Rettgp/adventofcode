defmodule Mix.Tasks.Day1Part1 do
  use Mix.Task

  @shortdoc "Run Day1.part1/1 with a file path argument"
  def run([file_path]) do
    result = Day1.part1(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day1_part1 <file_path>")
end
