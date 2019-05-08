# https://www.youtube.com/watch?v=dRqr5KTwziQ

one..ten = 1..10

IO.puts one
IO.puts ten

twenty..two = 20..2

IO.puts twenty
IO.puts two

1..10 |> Enum.to_list |> IO.inspect

10..1 |> Enum.each(&IO.puts/1)
