defmodule Fibonacci do
  def calc(0), do: 0
  def calc(1), do: 1
  def calc(2), do: 1
  def calc(n) do
    Enum.reduce(3..n, {1, 1}, fn _, {curr, prev} -> {curr + prev, curr} end)
  end

  def compute(n, curr \\ 0, next \\ 1)
  def compute(0, curr, next), do: {curr, next}
  def compute(n, curr, next), do: compute(n-1, next, curr + next)
end

# Enum.map(1..37, &Fibonacci.calc/1)

# Enum.map(1..37, &Fibonacci.compute/1) |> Enum.map(fn {value, _} -> value end)

Benchee.run(%{
  "Fibonacci.calc/1" => fn -> Enum.map(1..37, &Fibonacci.calc/1) end,
  "Fibonacci.compute/1" => fn -> Enum.map(1..37, &Fibonacci.compute/1) end
})
