defmodule Slug1 do
  def slugify(input), do: map_slug(input, %{pattern: ~r/\s+/})

  def slugify2(input), do: map_slug(input, %{pattern: " "})

  defp map_slug(input, %{pattern: pattern}) do
    input
    |> to_string()
    |> String.trim()
    |> String.downcase()
    |> String.replace(pattern, "-")
  end
end

# ---

defmodule Slug2 do
  def slugify(input), do: map_slug(input, [pattern: ~r/\s+/])

  def slugify2(input), do: map_slug(input, [pattern: " "])

  defp map_slug(input, keywords) do
    pattern = Keyword.fetch!(keywords, :pattern)

    input
    |> to_string()
    |> String.trim()
    |> String.downcase()
    |> String.replace(pattern, "-")
  end
end

# ---

defmodule Slug3 do
  def slugify(input) do
    replacer(~r/\s+/)
    |> map_slug(input)
  end

  def slugify2(input) do
    replacer(" ")
    |> map_slug(input)
  end

  defp map_slug(replace, input) do
    to_string(input)
    |> String.trim()
    |> String.downcase()
    |> replace.()
  end

  defp replacer(pattern) do
    &(String.replace(&1, pattern, "-"))
  end
end

# ---

text = " I   WILL be a url slug   "

result_of = fn(fn_name, %{to: text}) ->
  &(apply(&1, fn_name, [text]))
end

results_must_be_equal_to = fn(expected_text) ->
  &(&1 == expected_text)
end

Enum.map([Slug1, Slug2, Slug3], result_of.(:slugify, %{to: text}))
|> Enum.all?(results_must_be_equal_to.("i-will-be-a-url-slug"))
|> IO.puts()

# ---

Enum.map([Slug1, Slug2, Slug3], &(apply(&1, :slugify2, [text])))
|> Enum.all?(&(&1 == "i---will-be-a-url-slug"))
|> IO.puts()
