############################
# Abstracting with structs #
############################
# Define and enforce a more precise structure definition.

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new, do: %TodoList{}

  def add_entry(%TodoList{}=todo_list, %{}=entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )

    %TodoList{todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def entries(%TodoList{}=todo_list, %Date{}=date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def due_today(%TodoList{}=todo_list) do
    entries(todo_list, Date.utc_today)
  end
end

today = Date.utc_today
tomorrow = Date.add(today, 1)
yesterday = Date.add(today, -1)

todo_list =
  TodoList.new
  |> TodoList.add_entry(%{date: today, title: "Dentist"})
  |> TodoList.add_entry(%{date: tomorrow, title: "Movies"})
  |> TodoList.add_entry(%{date: tomorrow, title: "Shopping"})
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
