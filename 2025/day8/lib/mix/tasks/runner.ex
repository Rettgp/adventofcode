defmodule Mix.Tasks.Day8 do
  use Mix.Task

  @shortdoc "Run Day8.run/1 with a file path argument"
  def run([file_path]) do
    result = Day8.run(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day8 <file_path>")
end
