relation = [1, "not a number", 2, :x, 3]


###############################################
# Adding numbers with Enum.filter |> Enum.sum #
###############################################
relation
|> Enum.filter(fn element -> is_number(element) end)
|> Enum.sum
|> IO.inspect

relation
|> Enum.filter(&(is_number(&1)))
|> Enum.sum
|> IO.inspect

relation
|> Enum.filter(&is_number/1)
|> Enum.sum
|> IO.inspect

###################################
# Adding numbers with Enum.reduce #
###################################

relation
|> Enum.reduce(
  0,
  fn
    element, acc when is_number(element) -> acc + element
    _, acc -> acc
  end
)
|> IO.inspect

sum_only_numbers = fn
  element, acc when is_number(element) -> acc + element
  _, acc -> acc
end

relation
|> Enum.reduce(0, sum_only_numbers)
|> IO.inspect

defmodule Adder do
  def sum(relation) do
    Enum.reduce(relation, 0, &sum_only_numbers/2)
  end

  defp sum_only_numbers(item, acc) when is_number(item) do
    acc + item
  end
  defp sum_only_numbers(_, acc), do: sum
end

Adder.sum(relation)
|> IO.inspect

