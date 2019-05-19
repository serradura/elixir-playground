defmodule NaturalNums do
  def print(to) when is_float(to), do: trunc(to) |> print()

  def print(to) when is_integer(to) and to != 0 do
    from = if to > 0, do: 1, else: -1

    Enum.each(from..to, &IO.puts/1)
  end
end

defmodule NaturalNums1 do
  import IO, only: [puts: 1]

  def print(1), do: puts(1)
  def print(-1), do: puts(-1)
  def print(n) when is_float(n), do: trunc(n) |> print()
  def print(n) when is_integer(n) and n > 0, do: print(n-1) && puts(n)
  def print(n) when is_integer(n) and n < 0, do: print(n+1) && puts(n)
end

defmodule NaturalNums2 do
  import IO, only: [puts: 1]

  def print(n) when n in [1, -1], do: puts(n)
  def print(n) when is_float(n), do: trunc(n) |> print()
  def print(n) when is_integer(n) and n > 0, do: print(n-1) && puts(n)
  def print(n) when is_integer(n) and n < 0, do: print(n+1) && puts(n)
end

defmodule NaturalNums3 do
  def print(value) do
    if is_number(value) do
      n = (is_float(value) && trunc(value)) || value

      if n != 0 do
        print(if n > 0, do: n-1, else: n+1)
        IO.puts(n)
      else
        :ok
      end
    end
  end
end

defmodule NaturalNums4 do
  def print(n) when is_float(n), do: trunc(n) |> print()

  def print(n) when is_integer(n) do
    if n != 0 do
      print(if n > 0, do: n-1, else: n+1)
      IO.puts(n)
    end

    :ok
  end
end

# Inspired by https://gist.github.com/umamaistempo/f4ab46379fb69f0b173f4adf37feb402
defmodule Bla do
  def print(n) when is_float(n),
    do: print(trunc(n))
  def print(n) when n < 0,
    do: do_print(n, -1)
  def print(n) when n > 0,
    do: do_print(n, 1)

  defp do_print(n, n),
    do: IO.puts(n)
  defp do_print(n, acc) when n < 0,
    do: IO.puts(acc) && do_print(n, acc - 1)
  defp do_print(n, acc) when n > 0,
    do: IO.puts(acc) && do_print(n, acc + 1)
end

defmodule NaturalNums.TailCallOptimization.V1 do
  import IO, only: [puts: 1]

  def print(n) when is_float(n), do: trunc(n) |> print()
  def print(n) when is_integer(n) and n > 0, do: do_print(n, 1)
  def print(n) when is_integer(n) and n < 0, do: do_print(n, -1)

  defp do_print(n, n), do: puts(n)
  defp do_print(n, acc) when n > 0, do: puts(acc) && do_print(n, acc + 1)
  defp do_print(n, acc) when n < 0, do: puts(acc) && do_print(n, acc - 1)
end

defmodule NaturalNums.TailCallOptimization.V2 do
  import IO, only: [puts: 1]

  def print(n) when is_float(n), do: trunc(n) |> print()
  def print(n) when is_integer(n) and n > 0, do: do_print(n, 1, 1)
  def print(n) when is_integer(n) and n < 0, do: do_print(n, -1, -1)

  defp do_print(n, n, ref), do: puts(n)
  defp do_print(n, acc, ref), do: puts(acc) && do_print(n, ref + acc, ref)
end

NaturalNums.print(3)
NaturalNums.print(-3)

NaturalNums1.print(3)
NaturalNums1.print(-3)

NaturalNums2.print(3)
NaturalNums2.print(-3)

NaturalNums3.print(3)
NaturalNums3.print(-3)

NaturalNums4.print(3)
NaturalNums4.print(-3)

Bla.print(3)
Bla.print(-3)

NaturalNums.TailCallOptimization.V1.print(3)
NaturalNums.TailCallOptimization.V1.print(-3)

NaturalNums.TailCallOptimization.V2.print(3)
NaturalNums.TailCallOptimization.V2.print(-3)
