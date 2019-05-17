defmodule Fibonacci do
  alias Fibonacci.Computer

  def calc(0), do: 0
  def calc(1), do: 1
  def calc(2), do: 1
  def calc(n) do
    Enum.reduce(3..n, {1, 1}, fn _, {curr, prev} -> {curr + prev, curr} end)
  end

  def compute(n)
  def compute(n), do: Computer.calc(n)
end

defmodule Fibonacci.Computer do
  def calc(n, curr \\ 0, next \\ 1)
  def calc(0, curr, next), do: {curr, next}
  def calc(n, curr, next), do: calc(n-1, next, curr + next)
end

# Enum.map(1..37, &Fibonacci.calc/1)

# Enum.map(1..37, &Fibonacci.compute/1) |> Enum.map(fn {value, _} -> value end)

Benchee.run(%{
  "Fibonacci.calc/1" => fn -> Enum.map(1..37, &Fibonacci.calc/1) end,
  "Fibonacci.compute/1" => fn -> Enum.map(1..37, &Fibonacci.compute/1) end
})
