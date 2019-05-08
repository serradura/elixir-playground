# https://www.youtube.com/watch?v=bkNCsbD4y5Q

a = 1

{^a, b} = {1, 2}

IO.puts a == 1 && b == 2

try do
  {^a, _} = {2, 2}
rescue
  e in MatchError -> IO.inspect(e)
end

value = "foo"
desired_value = "foo"

case value do
  ^desired_value ->
    IO.puts "Pinned match!"
  _ ->
    :ok
end
|> IO.inspect

