defmodule Mix.Tasks.Day5 do
  use Mix.Task

  @shortdoc "Run Day5.run/1 with a file path argument"
  def run([file_path]) do
    result = Day5.run(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day5 <file_path>")
end
