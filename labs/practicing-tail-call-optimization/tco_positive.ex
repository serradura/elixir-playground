defmodule TCO do
  def positive(list) when is_list(list) do
    do_positive(list, [])
  end

  defp do_positive([], acc), do: acc
  defp do_positive(list, acc) do
    [head | tail] = list

    new_acc = if is_number(head) and head > 0, do: [head] ++ acc, else: acc

    do_positive(tail, new_acc)
  end
end
