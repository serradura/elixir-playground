# https://www.youtube.com/watch?v=7u2kIbIzv0s

# Map - Key and value data container
# Syntax %{ :a => "1" }

a = %{:a => 1}
b = %{"b" => 2}
c = %{:map => a, :c => 3, :d => b}

IO.inspect(a)
IO.inspect(b)
IO.inspect(c)
IO.inspect(c[:map][:a])
IO.inspect(c[:d]["b"])
