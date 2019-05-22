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

defmodule Cat do
  @enforce_keys [:name]
  defstruct name: ""

  def new(name) do
    %Cat{name: name}
  end

  defimpl Animal, for: Cat do
    def greet(_), do: "..."
    def speak(_), do: "meow"
    def warn(_), do: "hiss!"
  end
end

stela = Dog.new("Stela")
stela |> Animal.greet |> IO.puts
# woof! woof!

tabby = Cat.new("Tabby")
tabby |> Animal.greet |> IO.puts
# ...

Enum.map([stela, tabby], &Animal.speak/1)
|> IO.inspect(label: "My pets spoke")
# My pets spoke: ["woof", "meow"]
