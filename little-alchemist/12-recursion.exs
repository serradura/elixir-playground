# https://www.youtube.com/watch?v=JfXjMASBh_E

# Recursion = A function that calls itself until it reaches the final/expected state.

defmodule Recursion do
  def sum(_, total \\ 0)
  def sum([], total), do: total
  def sum(numbers, total) do
    [ number | remaining_numbers ] = numbers

    sum(remaining_numbers, number + total)
  end
end

must_be_equal_to_six = &(&1 == 6)

1..3
|> Enum.to_list
|> Recursion.sum
|> IO.inspect
|> must_be_equal_to_six.()
|> IO.puts
