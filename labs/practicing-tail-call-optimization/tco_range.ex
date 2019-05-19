defmodule TCO do
  def range(from, to) when is_integer(from) and is_integer(to) do
    do_range(from, to, [to])
  end

  defp do_range(from, from, list), do: list
  defp do_range(from, to, list) do
    next = if from < to, do: to - 1, else: to + 1

    do_range(from, next, [next | list])
  end
end
