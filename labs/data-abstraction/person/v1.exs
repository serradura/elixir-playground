defmodule Person do
  # instances the abstraction
  def new, do: new("John Doe")
  def new(name) when is_bitstring(name) do
    %{name: name, valid: false}
  end

  # modifier function
  def validate(%{name: _, valid: _} = person) do
    %{ person | valid: true }
  end

  # query function
  def valid?(%{valid: _} = person) do
    person.valid
  end

  # query function
  def hello(%{name: name}) do
    "Hello my name is #{name}"
  end

  # query function
  def has_name?(%{name: name}) do
    len = to_string(name) |> String.trim |> String.length
    len > 0
  end
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
|> Person.hello
|> IO.inspect(label: "Person.hello")
# Hello my name is John Doe

IO.puts("")

Person.new("Rodrigo")
|> Person.hello
|> IO.inspect(label: "Person.hello")
# Hello my name is Rodrigo
