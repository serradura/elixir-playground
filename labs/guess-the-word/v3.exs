defmodule GuessTheWord do
  def play(%{:hints => hints, :answer => answer}) do
    IO.puts "Hints: #{hints}"

    new_guess() |> attempt(answer)
  end

  def attempt(guess, answer) do
    if guess == answer do
      IO.puts "won!"
    else
      IO.puts "That is not correct!"

      new_guess() |> attempt(answer)
    end
  end

  defp new_guess do
    IO.gets("Guess the word: ")
    |> String.trim
    |> String.downcase
  end
end

GuessTheWord.play(%{
  :hints => "flour, water, yeast, bakery",
  :answer => "bread"
})
