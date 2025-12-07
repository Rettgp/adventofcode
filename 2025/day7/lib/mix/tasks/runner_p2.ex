defmodule Mix.Tasks.Day7Part2 do
  use Mix.Task

  @shortdoc "Run Day7.part2/1 with a file path argument"
  def run([file_path]) do
    result = Day7.run_p2(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day7_part2 <file_path>")
end
