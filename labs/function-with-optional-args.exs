# https://hexdocs.pm/elixir/Keyword.html#content

" a b c "
|> String.split(" ", trim: true)
|> IO.inspect(label: "Using keywords in functions as their options")

defmodule CalcPrinter do
  def sum(a, b, options \\ [])
  def sum(a, b, options) when is_list(options) do
    text = Keyword.get(options, :text)
    result = a + b
    content = (text && "#{text}: #{result}") || result

    IO.puts(content)
  end
end

CalcPrinter.sum(1, 2)
CalcPrinter.sum(2, 2, text: "add two and two")
CalcPrinter.sum(2, 2, [text: "add two and two"])
CalcPrinter.sum(2, 2, [{:text, "add two and two"}])
