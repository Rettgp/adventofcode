defmodule Mix.Tasks.Day1Part2 do
  use Mix.Task

  @shortdoc "Run Day1.part2/1 with a file path argument"
  def run([file_path]) do
    result = Day1.part2(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day1_part2 <file_path>")
end
