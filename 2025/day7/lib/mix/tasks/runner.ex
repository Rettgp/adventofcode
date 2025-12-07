defmodule Mix.Tasks.Day7 do
  use Mix.Task

  @shortdoc "Run Day7.run/1 with a file path argument"
  def run([file_path]) do
    result = Day7.run(file_path)
    IO.puts(result)
  end

  def run(_), do: IO.puts("Usage: mix day7 <file_path>")
end
