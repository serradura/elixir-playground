#####################
# Iterative updates #
#####################

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ [])
  def new(entries) when is_list(entries) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

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

  # Adds an alternative update interface, allowing to update with a map.
  def update_entry(%TodoList{}=todo_list, %{id: id} = new_entry) do
    update_entry(todo_list, id, &Map.merge(&1, new_entry))
  end

  def update_entry(%TodoList{}=todo_list, entry_id, updater) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list
      {:ok, old_entry} ->
        # Assert if the ID value of the entry hasn't been changed in the lambda.
        new_entry = %{id: ^entry_id} = updater.(old_entry)
        new_entries = Map.put(todo_list.entries, entry_id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def update_entry(%TodoList{}=todo_list, entry_id, key, value) do
    new_entries =
      put_in(todo_list.entries, [entry_id, key], value)

    %TodoList{todo_list | entries: new_entries}
  end

  def update_entry_title(%TodoList{}=todo_list, entry_id, title)
      when is_bitstring(title) do
    update_entry(todo_list, entry_id, :title, title)
  end

  def update_entry_date(%TodoList{}=todo_list, entry_id, %Date{}=date) do
    update_entry(todo_list, entry_id, :date, date)
  end

  def remove_entry(%TodoList{}=todo_list, entry_id) do
    new_entries = Map.delete(todo_list.entries, entry_id)

    %TodoList{todo_list | entries: new_entries}
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
  TodoList.new([
    %{date: today, title: "Dentist"},
    %{date: tomorrow, title: "Movies"},
    %{date: tomorrow, title: "Shopping"}
  ])
  |> IO.inspect(label: "todo_list")

IO.puts("")

todo_list
|> TodoList.due_today()
|> IO.inspect(label: "TodoList.due_today()")

IO.puts("")

todo_list
|> TodoList.update_entry(%{id: 1, date: tomorrow})
|> TodoList.entries(tomorrow)
|> IO.inspect(label: "TodoList.entries(#{tomorrow})")

IO.puts("")

todo_list
|> TodoList.entries(yesterday)
|> IO.inspect(label: "TodoList.entries(#{yesterday})")

IO.puts("")

todo_list
|> TodoList.update_entry(3, :title, "Theater")
|> IO.inspect(label: "todo_list")

IO.puts("")

todo_list
|> TodoList.update_entry_title(2, "Theater")
|> IO.inspect(label: "todo_list")

IO.puts("")

todo_list
|> TodoList.update_entry_date(1, yesterday)
|> TodoList.entries(yesterday)
|> IO.inspect(label: "TodoList.entries(#{yesterday})")

IO.puts("\nDeleting an entry:\n")

todo_list
|> TodoList.update_entry_date(1, yesterday)
|> TodoList.remove_entry(1)
|> IO.inspect()
|> TodoList.entries(yesterday)
|> IO.inspect(label: "\tTodoList.entries(#{yesterday})")
