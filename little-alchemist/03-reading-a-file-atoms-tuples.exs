# https://www.youtube.com/watch?v=tOkF5BVpKTQ&list=PLaY7qWIrmqtFoZLvOvYRZG5hl367UybRp&index=3

# Atom - a kind of data that have its value as its name
:ok

# Tuple - intended as fixed-size containers for multiple element.

# Example of how the File module reads a file an returns the results in a tuple
File.read("./loren")
# {:ok, "lorem ipsum...\n"}

File.read("./loren")
# {:error, :enoent}
