words = [
  %{ :hints => "farinha, água, fermento, padaria", :answer => "pão" },
  %{ :hints => "farinha, água, sal", :answer => "bolacha" }
]

[%{:hints => hints, :answer => answer}] = words |> Enum.take_random(1)

IO.puts "Hint: #{hints}"

guess =
  "Guess word: "
  |> IO.gets
  |> String.trim()
  |> String.downcase()

result = if guess == answer, do: "won", else: "lost"

IO.puts "#{result}!"
