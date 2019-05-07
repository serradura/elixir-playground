# https://www.youtube.com/watch?v=Ipddkt5DR2w&list=PLaY7qWIrmqtFoZLvOvYRZG5hl367UybRp&index=4

defmodule MyMod do
  # Like Ruby, Elixir returns the last value evaluated in a function by default
  def one do
    1
  end

  def read_my_file(filename) do
    case File.read(filename) do
      {:ok, content} ->
        content
      {:error, message} ->
        message
      _ ->
        nil
    end
  end
end
