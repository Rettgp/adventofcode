defmodule Mix.Tasks.Day9Part2 do
  use Mix.Task

  @shortdoc "Run Day9.part2/1 with a file path argument"
  def run([file_path]) do
    result = Day9.run_part2(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day9_part2 <file_path>")
end
