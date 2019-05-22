############################
# Abstracting with structs #
############################
# Define and enforce a more precise structure definition.

defmodule TodoList do
  defstruct entries: %{}

  def new, do: %TodoList{}

  def add_entry(%TodoList{}=todo_list, %{}=entry) do
    new_entries = Map.update(
      todo_list.entries,
      entry.date,
      [entry],
      &[entry | &1]
    )

    %TodoList{todo_list | entries: new_entries}
  end

  def entries(%TodoList{}=todo_list, %Date{}=date) do
    Map.get(todo_list.entries, date, [])
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
