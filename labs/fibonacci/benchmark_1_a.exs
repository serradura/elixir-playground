defmodule Fibonacci do
  def calc(0), do: 0
  def calc(1), do: 1
  def calc(2), do: 1
  def calc(n), do: calc(n - 1) + calc(n - 2)

  def compute(n, memo \\ %{})
  def compute(n, memo) do
    compute = computer()
    compute.(n, memo, compute)
  end

  def computer do
    fn
      0, memo, _ -> {0, memo}
      1, memo, _ -> {1, memo}
      2, memo, _ -> {1, memo}
      n, memo, compute ->
      if Map.has_key?(memo, n) do
        { memo[n], memo }
      else
        {n1, memo1} = compute.(n - 1, memo, compute)
        {n2, memo2} = compute.(n - 2, memo1, compute)

        value = n1 + n2

        {value, Map.merge(memo2, %{n => value})}
      end
    end
  end
end

# Enum.map(1..37, &Fibonacci.calc/1)

# Enum.map(1..37, &Fibonacci.compute/1) |> Enum.map(fn {value, _} -> value end)

Benchee.run(%{
  "Fibonacci.calc/1"    => fn -> Enum.map(1..37, &Fibonacci.calc/1) end,
  "Fibonacci.compute/1" => fn -> Enum.map(1..37, &Fibonacci.compute/1) end
})
