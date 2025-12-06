defmodule Mix.Tasks.Day6Part2 do
  use Mix.Task

  @shortdoc "Run Day6.part2/1 with a file path argument"
  def run([file_path]) do
    result = Day6.run_p2(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day6_part2 <file_path>")
end
