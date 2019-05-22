############################
# Abstracting with modules #
############################

defmodule TodoList do
  def new, do: %{}

  def add_entry(todo_list, date, title) do
    Map.update(
      todo_list,                        # map
      date,                             # key
      [title],                          # initial value, if no value exists for the given key.
      fn titles -> [title | titles] end # lambda updater
    )
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end

  def due_today(todo_list) do
    entries(todo_list, Date.utc_today)
  end
end

today = Date.utc_today
tomorrow = Date.add(today, 1)
yesterday = Date.add(today, -1)

todo_list =
  TodoList.new
  |> TodoList.add_entry(today, "Dentist")
  |> TodoList.add_entry(tomorrow, "Movies")
  |> TodoList.add_entry(tomorrow, "Shopping")
  |> IO.inspect(label: "todo_list")

IO.puts("")

todo_list
|> TodoList.due_today()
|> IO.inspect(label: "TodoList.due_today()")

IO.puts("")

todo_list
|> TodoList.entries(tomorrow)
|> IO.inspect(label: "TodoList.entries(#{tomorrow})")

IO.puts("")

todo_list
|> TodoList.entries(yesterday)
|> IO.inspect(label: "TodoList.entries(#{yesterday})")
