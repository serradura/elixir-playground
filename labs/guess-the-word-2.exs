defmodule GuessWord.Interactions do
  def show(value) do
    IO.puts value
  end

  def show_hints(hints) do
    show "Hints: #{hints}"
  end

  def gets_guess do
    "Guess word: "
      |> IO.gets
      |> String.trim()
      |> String.downcase()
  end
end

defmodule GuessWord.Game do
  def start(%{:hints => hints, :answer => answer}) do
    GuessWord.Interactions.show_hints(hints)
    GuessWord.Interactions.gets_guess
      |> gets_result(answer)
      |> GuessWord.Interactions.show()
  end

  defp gets_result(guess, answer) do
    if guess == answer, do: "won!", else: "lost!"
  end
end

defmodule WordsToGuess do
  @list [
    %{ :hints => "farinha, água, fermento, padaria", :answer => "pão" },
    %{ :hints => "farinha, água, sal", :answer => "bolacha" }
  ]

  def sample do
    @list |> Enum.take_random(1) |> List.first()
  end
end

GuessWord.Game.start(WordsToGuess.sample)
