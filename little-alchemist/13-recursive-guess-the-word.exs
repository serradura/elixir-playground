# https://www.youtube.com/watch?v=lSqOCD9oIAQ

defmodule GuessTheWord do
  def play do
    hints = "flour, water, yeast, bakery"
    IO.puts "Hints: #{hints}"

    new_guess() |> attempt
  end

  def attempt("bread"), do: IO.puts "won!"
  def attempt(_wrong_guess) do
    IO.puts "That is not correct!"

    new_guess() |> attempt
  end

  defp new_guess do
    IO.gets("Guess the word: ")
    |> String.trim
    |> String.downcase
  end
end

GuessTheWord.play
