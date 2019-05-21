defmodule Person do
  defstruct name: "", valid: false

  # instances the abstraction
  def new, do: new("John Doe")
  def new(name) when is_bitstring(name) do
    %Person{name: name}
  end

  # modifier function
  def validate(%Person{} = person) do
    %{ person | valid: true }
  end

  # query function
  def valid?(%Person{} = person) do
    person.valid
  end

  # query function
  def has_name?(%Person{name: name}) do
    name
    |> String.trim()
    |> String.length()
    |> (&(&1 > 0)).()
  end
end

defmodule Person.Greetings do
  def hello(%Person{} = person) do
    "Hello my name is #{person.name}"
  end

  def hello!(%Person{valid: true} = person), do: hello(person)
  def hello!(_), do: {:error, "%Person{} must be valid"}
end

Person.new
|> Person.has_name?
|> IO.inspect(label: "Person.has_name?")
# true

IO.puts("")

Person.new("")
|> Person.has_name?
|> IO.inspect(label: "Person.has_name?")
# false

IO.puts("")

Person.new
|> Person.valid?
|> IO.inspect(label: "Person.valid?")

IO.puts("")

Person.new("Rodrigo")
|> Person.validate
|> IO.inspect(label: "Person.validate")
|> Person.valid?
|> IO.inspect(label: "Person.valid?")

IO.puts("")

Person.new
|> Person.Greetings.hello
|> IO.inspect(label: "Person.Greetings.hello")
# Hello my name is John Doe

IO.puts("")

Person.new("Rodrigo")
|> Person.Greetings.hello
|> IO.inspect(label: "Person.Greetings.hello")
# Hello my name is Rodrigo

IO.puts("")

Person.new("Rodrigo")
|> Person.validate
|> Person.Greetings.hello!
|> IO.inspect(label: "Person.Greetings.hello!")
# Hello my name is Rodrigo

IO.puts("")

Person.new("Rodrigo")
|> Person.Greetings.hello!
|> IO.inspect(label: "Person.Greetings.hello!")
# {:error, "%Person{} must be valid"}
