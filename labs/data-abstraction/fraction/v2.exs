############################
# Abstracting with structs #
############################

defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b) when is_integer(a) and is_integer(b) do
    %Fraction{a: a, b: b}
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    a = a1 * b2 + a2 * b1
    b = b1 * b2

    new(a, b)
  end

  def value(%Fraction{a: a, b: b}) do
    a / b
  end
end

Fraction.add(
  Fraction.new(1, 2),
  Fraction.new(1, 4)
)
|> Fraction.value
|> IO.inspect

##############
# Try in iex #
##############
# one_half = %Fraction{a: 1, b: 2}
# one_quarter = %Fraction{one_half | b: 4}

Fraction.new(1, 2) |> inspect(structs: false) |> IO.puts()
