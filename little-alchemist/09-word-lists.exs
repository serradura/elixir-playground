# https://www.youtube.com/watch?v=Kpu00n-mXy4

words = ["another", "brick", "in", "the", "wall"]

IO.inspect words

list_with_strings = ~w(another brick in the wall)
# ["another", "brick", "in", "the", "wall"]

IO.inspect list_with_strings

list_with_atoms = ~w(another brick in the wall)a
# [:another, :brick, :in, :the, :wall]

IO.inspect list_with_atoms

list_with_chars = ~w(another brick in the wall)c
# ['another', 'brick', 'in', 'the', 'wall']

IO.inspect list_with_chars
