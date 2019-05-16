defmodule Calculator do
  alias Calculator.Operations

  @operation_pattern ~r/(\D)\s*(\d+(\.\d+)?)/

  def calculate(input, accumulator) do
    try do
      input
      |> String.trim()
      |> String.downcase()
      |> parse_operator_and_number()
      |> apply_operation_to(accumulator)
    rescue
      ArithmeticError -> 0
    end
  end

  defp parse_operator_and_number("exit"), do: :exit
  defp parse_operator_and_number(input) do
    try do
      [[_, operator, value | _]] = Regex.scan(@operation_pattern, input)

      {number, _} = Float.parse(value)

      [operator, number]
    rescue
      MatchError -> :error
    end
  end

  defp apply_operation_to(:exit, _accumulator), do: :exit
  defp apply_operation_to(:error, _accumulator), do: :error
  defp apply_operation_to([operator, number], accumulator) do
    case Operations.name(operator) do
      nil -> :error
      name -> apply(Operations, name, [accumulator, number])
    end
  end
end

defmodule Calculator.Operations do
  @operators %{
    "+" => :add,
    "-" => :subtract,
    "*" => :multiply,
    "x" => :multiply,
    "/" => :divide
  }

  def add(a, b), do: a + b
  def subtract(a, b), do: a - b
  def multiply(a, b), do: a * b
  def divide(a, b), do: a / b

  def name(operator), do: @operators[operator]
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
