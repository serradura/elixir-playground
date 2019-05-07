# https://www.youtube.com/watch?v=28UIBW2CeVc&list=PLaY7qWIrmqtFoZLvOvYRZG5hl367UybRp&index=6

#  Takes the output of the function at the left and pass it to the function at the right.

input = "foo@email.com,bar@EMAIL.com,FOO@email.com"

IO.inspect Enum.uniq(String.split(String.downcase(input), ","))

String.downcase(input) |> String.split(",") |> Enum.uniq() |> IO.inspect()

input |> String.downcase() |> String.split(",") |> Enum.uniq() |> IO.inspect()

input
|> String.downcase()
|> String.split(",")
|> Enum.uniq()
|> IO.inspect()

input
|> String.downcase()
|> IO.inspect(label: "emails") # Using IO.inspect to observer the
|> String.split(",")           # data transformation inside of the pipeline.
|> Enum.uniq()
|> IO.inspect()

"foo@email.com, bar@EMAIL.com, FOO@email.com"
|> String.downcase()
|> String.split(",")
|> Enum.map(fn str -> String.trim(str) end)
|> Enum.uniq()
|> IO.inspect()

"foo@email.com, bar@EMAIL.com, FOO@email.com"
|> String.downcase()
|> String.split(",")
|> Enum.map(&(String.trim(&1)))
|> Enum.uniq()
|> IO.inspect()

"foo@email.com, bar@EMAIL.com, FOO@email.com"
|> String.downcase()
|> String.split(",")
|> Enum.map(&(&1 |> String.trim()))
|> Enum.uniq()
|> IO.inspect()

"foo@email.com, bar@EMAIL.com, FOO@email.com"
|> String.downcase()
|> String.split(",")
|> Enum.map(&String.trim/1)
|> Enum.uniq()
|> IO.inspect()
