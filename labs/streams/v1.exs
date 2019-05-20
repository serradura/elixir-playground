defmodule FileReaderUtils do
  def large_lines!(path, options \\ [])
  def large_lines!(path, options) do
    limit = Keyword.get(options, :limit, 80)

    file_stream!(path)
    |> Enum.filter(&(String.length(&1) > limit))
  end

  def lines_lengths!(path) do
    lines_lengths_stream!(path)
    |> Enum.to_list()
  end

  def longest_line_length!(path) do
    lines_lengths_stream!(path)
    |> Enum.max()
  end

  def longest_line!(path) do
    file_stream!(path)
    |> Enum.max_by(&String.length/1)
  end

  def words_per_line!(path) do
    file_stream!(path)
    |> Stream.map(&count_line_words/1)
    |> Enum.to_list()
  end

  def words_by_line!(path) do
    file_stream!(path)
    |> Stream.with_index(1)
    |> Stream.map(fn {line, index} -> {count_line_words(line), index} end)
    |> Enum.to_list()
  end

  defp file_stream!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  defp lines_lengths_stream!(path) do
    file_stream!(path)
    |> Stream.map(&String.length/1)
  end

  defp count_line_words(line) do
    length(String.split(line))
  end
end

txt_file = "#{__DIR__}/friends-s1e1.txt"

FileReaderUtils.large_lines!(txt_file)
|> IO.inspect(label: "FileReaderUtils.large_lines!")

IO.puts("")

FileReaderUtils.large_lines!(txt_file, limit: 500)
|> IO.inspect(label: "FileReaderUtils.large_lines!(..., limit: 500)")

IO.puts("")

FileReaderUtils.lines_lengths!(txt_file)
|> IO.inspect(label: "FileReaderUtils.lines_lengths!")

IO.puts("")

FileReaderUtils.longest_line_length!(txt_file)
|> IO.inspect(label: "FileReaderUtils.longest_line_length!")

IO.puts("")

FileReaderUtils.longest_line!(txt_file)
|> IO.inspect(label: "FileReaderUtils.longest_line!")

IO.puts("")

FileReaderUtils.words_per_line!(txt_file)
|> IO.inspect(label: "FileReaderUtils.words_per_line!")

IO.puts("")

FileReaderUtils.words_by_line!(txt_file)
|> IO.inspect(label: "FileReaderUtils.words_by_line!")
