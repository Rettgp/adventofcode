defmodule Mix.Tasks.Day6 do
  use Mix.Task

  @shortdoc "Run Day6.run/1 with a file path argument"
  def run([file_path]) do
    result = Day6.run(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day6 <file_path>")
end
