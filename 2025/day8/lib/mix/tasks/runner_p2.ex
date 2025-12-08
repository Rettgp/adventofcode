defmodule Mix.Tasks.Day8Part2 do
  use Mix.Task

  @shortdoc "Run Day8.part2/1 with a file path argument"
  def run([file_path]) do
    result = Day8.run_p2(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day8_part2 <file_path>")
end
