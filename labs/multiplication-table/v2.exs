defmodule MultiplicationTable do
  def generate(from, to) when is_integer(from) and is_integer(to) do
    for x <- from..to, y <- 1..10, into: %{} do
      {{x, y}, x * y}
    end
  end

  def get_numbers_and_print do
    print_title("Multiplication Table")

    {from, to} = get_numbers()

    generate(from, to)
    |> Enum.group_by(fn {{x, _}, _} -> x end)
    |> Enum.each(&print_table/1)
  end

  defp get_numbers do
    {get_number("From number:"), get_number("To number:")}
  end

  defp get_number(label) do
    IO.gets("#{label} ")
    |> String.trim()
    |> Integer.parse()
    |> elem(0)
  end

  defp print_title(title) when not is_binary(title) do
    print_title("#{title}")
  end

  defp print_title(title) do
    divider = String.duplicate("=", String.length(title))

    IO.puts("")
    IO.puts(title)
    IO.puts(divider)
    IO.puts("")
  end

  defp print_table({number, results}) do
    print_title(number)

    results
    |> Enum.sort(fn {{_, ya}, _}, {{_, yb}, _} -> ya < yb end)
    |> Enum.map(fn {{x, y}, z} -> "#{x} x #{y} = #{z}" end)
    |> Enum.join("\n")
    |> IO.puts()
  end
end

MultiplicationTable.get_numbers_and_print()
