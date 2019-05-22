# https://www.youtube.com/watch?v=NB58aFTZmrE&list=PLFhQVxlaKQEnTKMy4cprwyVeZJo00aVXV&index=2

defprotocol Animal do
  def greet(arg)
  def speak(arg)
  def warn(arg)
end

defmodule Dog do
  @enforce_keys [:name]
  defstruct name: ""

  def new(name) do
    %Dog{name: name}
  end

  defimpl Animal, for: Dog do
    def greet(_), do: "woof! woof!"
    def speak(_), do: "woof"
    def warn(_), do: "growl!"
  end
end

Dog.new("A") |> Animal.greet() |> IO.puts
# woof! woof!
