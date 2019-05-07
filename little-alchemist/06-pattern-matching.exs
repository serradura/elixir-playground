# https://www.youtube.com/watch?v=79WCxJ9TM1o&list=PLaY7qWIrmqtFoZLvOvYRZG5hl367UybRp&index=5

# In Elixir the equal signal "=" makes a pattern matching operation instead of a regular assignment.
# It tries to match values at right with values at in the left.

foo = 3
IO.puts foo

bar = "whatever"
IO.puts bar

[foo, bar] = [1, 2]
IO.puts foo
IO.puts bar

[a,b,c] = [1,2, [3,4]]
IO.inspect a
IO.inspect b
IO.inspect c

[a,b,[c, d]] = [1,2, [3,4]]
IO.inspect a
IO.inspect b
IO.inspect c
IO.inspect d

%{:key => v } = %{:key => "value"}
IO.puts v

defmodule MyOtherMod do
  def mapping(%{"key" => value}) do
    IO.puts value
  end
end

MyOtherMod.mapping(%{"key" => "My supper stuff"})

# pin operator "^" allows you to make a pattern matching using the value inside of the variable to make a comparation
[n, ^v] = [5, "value"]
IO.inspect n
IO.inspect v

try do
  ^v = "different value"
rescue
  e in RuntimeError -> IO.inspect e
end
