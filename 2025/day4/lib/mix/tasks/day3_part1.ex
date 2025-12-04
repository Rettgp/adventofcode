defmodule Mix.Tasks.Day4Part1 do
  use Mix.Task

  @shortdoc "Run Day4.part1/1 with a file path argument"
  def run([file_path]) do
    result = Day4.part1(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day4_part1 <file_path>")
end
