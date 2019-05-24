defmodule Calculator do
  alias Calculator.Operations

  @operation_pattern ~r/(\D)\s*(\d+(\.\d+)?)/

  def calculate(input, accumulator) do
    input
    |> String.trim()
    |> String.downcase()
    |> parse_operator_and_number()
    |> apply_operation_to(accumulator)
  end

  defp parse_operator_and_number("exit"), do: :exit
  defp parse_operator_and_number(input) when is_bitstring(input) do
    Regex.scan(@operation_pattern, input)
    |> parse_operator_and_number()
  end
  defp parse_operator_and_number([]), do: :error
  defp parse_operator_and_number([[_, operator, value | _]]) do
    {number, _} = Float.parse(value)

    [operator, number]
  end

  defp apply_operation_to(["+", a], b), do: b + a
  defp apply_operation_to(["-", a], b), do: b - a
  defp apply_operation_to(["/", 0.0], _), do: :error
  defp apply_operation_to(["/", a], b), do: b / a
  defp apply_operation_to([operator, a], b) when operator in ["*", "x"], do: b * a
  defp apply_operation_to([_, _], _), do: :error
  defp apply_operation_to(:error, _accumulator), do: :error
  defp apply_operation_to(:exit, _accumulator), do: :exit
end

defmodule Calculator.REPL do
  def run(accumulator \\ 0.0, options \\ [])
  def run(accumulator, options) do
    puts_total?(options) && puts_total(accumulator)

    result = gets_input() |> Calculator.calculate(accumulator)

    case result do
      :error -> puts_invalid_operation() && run(accumulator, puts_total?: false)
      :exit -> System.halt()
      total -> run(total)
    end
  end

  defp gets_input, do: IO.gets("<< ")

  defp puts_total(total), do: IO.puts(">> #{format_float_as_decimal(total)}")
  defp puts_total?(options), do: Keyword.get(options, :puts_total?, true)

  defp puts_invalid_operation do
    IO.puts("!! Please, try again or enter EXIT to turn-off.")
  end

  defp format_float_as_decimal(accumulator) do
    accumulator
      |> :erlang.float_to_binary([decimals: 20])
      |> String.replace(~r/00+$/, "0")
      |> String.replace(~r/\.0$/, ".00")
  end
end

Calculator.REPL.run()
