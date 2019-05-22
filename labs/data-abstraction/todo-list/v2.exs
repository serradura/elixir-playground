##########################
# Composing abstractions #
##########################

defmodule MultiDict do
  def new, do: %{}

  def add(dic, key, value) do
    Map.update(dic, key, [value], &[value | &1])
  end

  def get(dic, key) do
    Map.get(dic, key, [])
  end
end

defmodule TodoList do
  def new, do: MultiDict.new()

  def add_entry(todo_list, date, title) do
    MultiDict.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
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
