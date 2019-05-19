defmodule Person do
  def new(name) do
    builder = fn ->
      %{
        name: name,
        hello: fn -> "Hello, my name is #{name}." end
      }
    end

    builder.()
  end
end

person = Person.new("Rodrigo")

IO.puts person.name     # "Rodrigo"
IO.puts person.hello.() # "Hello, my name is Rodrigo."
