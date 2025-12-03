defmodule Mix.Tasks.Day3Part2 do
  use Mix.Task

  @shortdoc "Run Day3.part2/1 with a file path argument"
  def run([file_path]) do
    result = Day3.part2(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day3_part2 <file_path>")
end
