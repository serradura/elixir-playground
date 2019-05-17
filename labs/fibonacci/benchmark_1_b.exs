defmodule Fibonacci do
  alias Fibonacci.Computer

  def calc(0), do: 0
  def calc(1), do: 1
  def calc(2), do: 1
  def calc(n), do: calc(n - 1) + calc(n - 2)

  def compute(n, memo \\ %{})
  def compute(n, memo), do: Computer.calc(n, memo)
end

defmodule Fibonacci.Computer do
  def calc(n, memo)
  def calc(0, memo), do: {0, memo}
  def calc(1, memo), do: {1, memo}
  def calc(2, memo), do: {1, memo}
  def calc(n, memo) do
    if Map.has_key?(memo, n) do
      { memo[n], memo }
    else
      {n1, memo1} = calc(n - 1, memo)
      {n2, memo2} = calc(n - 2, memo1)

      value = n1 + n2

      {value, Map.merge(memo2, %{n => value})}
    end
  end
end

# Enum.map(1..37, &Fibonacci.calc/1)

# Enum.map(1..37, &Fibonacci.compute/1) |> Enum.map(fn {value, _} -> value end)

Benchee.run(%{
  "Fibonacci.calc/1" => fn -> Enum.map(1..37, &Fibonacci.calc/1) end,
  "Fibonacci.compute/1" => fn -> Enum.map(1..37, &Fibonacci.compute/1) end
})
