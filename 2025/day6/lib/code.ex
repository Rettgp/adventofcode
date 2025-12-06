defmodule Day6 do
  @moduledoc """
  """
  defp op_fn("+"), do: &Enum.sum/1
  defp op_fn("-"), do: fn [h | t] -> Enum.reduce(t, h, &(&1 - &2)) end
  defp op_fn("*"), do: fn nums -> Enum.reduce(nums, 1, &(&1 * &2)) end
  defp op_fn("/"), do: fn [h | t] -> Enum.reduce(t, h, &(&1 / &2)) end

  def solve({nums, op}) do
    func = op_fn(op)
    func.(nums)
  end

  def run(file_path) do
    file_path
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
    |> Enum.map(fn line ->
      line
      |> String.replace(~r/\s+/, " ")
      |> String.split(" ", trim: true)
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn op ->
      {op |> Enum.reverse() |> tl() |> Enum.reverse(), List.last(op) |> String.replace("~", "")}
    end)
    |> Enum.map(&solve/1)
    |> IO.inspect(label: "Solved")
    |> Enum.sum()
    |> IO.inspect(label: "Total")
  end

  def run_p2(file_path) do
    lines =
      file_path
      |> File.read!()
      |> String.split(~r/\r?\n/, trim: false)

    max_len =
      lines
      |> Enum.map(&String.length/1)
      |> Enum.max(fn -> 0 end)

    padded =
      Enum.map(lines, &String.pad_trailing(&1, max_len, " "))

    occupied =
      0..(max_len - 1)
      |> Enum.map(fn i ->
        Enum.any?(padded, fn line ->
          String.at(line, i) != " "
        end)
      end)

    ranges =
      occupied
      |> Enum.with_index()
      |> Enum.chunk_by(fn {occ, _} -> occ end)
      |> Enum.filter(fn chunk ->
        case hd(chunk) do
          {occ, _} -> occ
        end
      end)
      |> Enum.map(fn chunk ->
        idxs = Enum.map(chunk, fn {_, idx} -> idx end)
        {hd(idxs), List.last(idxs)}
      end)

    fixed_strings =
      Enum.map(padded, fn line ->
        Enum.map(ranges, fn {start, last} ->
          len = last - start + 1

          line
          |> String.slice(start, len)
          |> String.replace(" ", "~")
        end)
      end)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    fixed_strings
    |> Enum.map(fn op ->
      {op |> Enum.reverse() |> tl() |> Enum.reverse(), List.last(op) |> String.replace("~", "")}
    end)
    |> Enum.map(fn {nums, op} ->
      nums =
        nums
        |> Enum.map(&String.graphemes/1)
        |> Enum.zip()
        |> Enum.map(&Tuple.to_list/1)
        |> Enum.reverse()
        |> Enum.map(fn col ->
          col
          |> Enum.reject(&(&1 == "~"))
          |> Enum.join()
          |> String.to_integer()
        end)

      {nums, op}
    end)
    |> Enum.map(&solve/1)
    |> IO.inspect(label: "Solved")
    |> Enum.sum()
    |> IO.inspect(label: "Total")
  end
end
