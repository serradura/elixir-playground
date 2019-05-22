############################
# Abstracting with structs #
############################

defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  def add(%Fraction{} = f1, %Fraction{} = f2) do
    a = f1.a * f2.b + f2.a * f1.b
    b = f1.b * f2.b

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
