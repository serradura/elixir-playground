defmodule TCO do
  def list_len(list) when is_list(list) do
    do_list_len(list, 0)
  end

  defp do_list_len([], acc), do: acc
  defp do_list_len([_ | tail], acc) do
    do_list_len(tail, acc + 1)
  end
end
