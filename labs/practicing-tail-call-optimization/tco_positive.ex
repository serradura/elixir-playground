defmodule TCO do
  def positive(list) when is_list(list) do
    do_positive(list, [])
  end

  defp do_positive([], acc), do: acc
  defp do_positive([head | tail], prev_acc) do
    acc = if is_number(head) and head > 0, do: [head | prev_acc], else: prev_acc

    do_positive(tail, acc)
  end
end
