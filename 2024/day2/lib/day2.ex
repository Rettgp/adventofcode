defmodule Day2 do
  @moduledoc """
  Validate that given rows of reports, where each report
  is an integer, all rows are either consistenty increase/decreasing.
  Any two adjacent reports should differ by atleast 1 but no more than 3


  Ex.
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """
  @doc """
  """

  defmodule Report do
    @enforce_keys [:values]
    defstruct values: []

    @type t() :: %__MODULE__{
      values: list(integer())
    }

    @spec safe?(Day2.Report.t(), integer()) :: boolean()
    def safe?(report, 0) do
      chunks = Enum.chunk_every(report.values, 2, 1, :discard)

      increasing_safety_levels = chunks
        |> Enum.map(fn [a, b] -> a < b end)
      decreasing_safety_levels = chunks
        |> Enum.map(fn [a, b] -> a > b end)
      within_3_safety_levels = chunks
        |> Enum.map(fn [a, b] -> abs(b - a) <= 3 end)

      (Enum.all?(increasing_safety_levels) or Enum.all?(decreasing_safety_levels))
        and Enum.all?(within_3_safety_levels)
    end

    def safe?(report, dampening_level) do
      safe_list = for n <- 0..length(report.values) do
        modified_report = %Report{values: List.delete_at(report.values, n)}
        Report.safe?(modified_report, dampening_level - 1)
      end

      if length(safe_list) == 0 do
        true
      else
        Enum.any?(safe_list);
      end
    end
  end

  @spec create_reports(String.t()) :: list(Report.t())
  def create_reports(input_string) when is_binary(input_string) do
    String.split(input_string, ~r/\r?\n/, trim: true)
    |> Enum.map(fn report_string ->
        integer_list = String.split(report_string)
          |> Enum.map(fn val -> String.to_integer(val) end)
        %Report{values: integer_list}
      end)
  end

end
