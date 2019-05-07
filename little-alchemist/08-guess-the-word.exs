# https://www.youtube.com/watch?v=GogZpXc8rGA&list=PLaY7qWIrmqtFoZLvOvYRZG5hl367UybRp&index=7

hints = "flour, water, yeast, bakery"
IO.puts "Hints: #{hints}"

guess =
  "Guess the word: "
  |> IO.gets
  |> String.trim

message = if guess == "bread", do: "won", else: "lost"

IO.puts "#{message}!"
