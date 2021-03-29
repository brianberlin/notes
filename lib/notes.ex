defmodule Notes do
  use Bakeware.Script

  def main([category, name]), do: open(category, name)
  def main([]), do: open_journal()

  def open(category, name) do
    open_vscode(note_path(category, name))
    IO.puts("✓")
  end

  def open_journal() do
    open_vscode(note_path())
    IO.puts("✓")
  end

  defp open_vscode(full_path) do
    File.mkdir_p!("#{notes_dir()}/#{Path.dirname(full_path)}")
    File.touch!("#{notes_dir()}/#{full_path}")
    System.cmd("code", [notes_dir()])
    System.cmd("code", ["#{notes_dir()}/#{full_path}"])
  end

  defp notes_dir, do: "#{System.user_home!()}/.notes"

  defp note_path do
    [year, month, day] =
      :calendar.local_time()
      |> elem(0)
      |> Tuple.to_list()
      |> Enum.map(&pad_integer/1)

    Path.join(["Journal", year, month, day <> ".md"])
  end

  defp note_path(category, name) do
    Path.join([category, name <> ".md"])
  end

  defp pad_integer(integer) when is_integer(integer) do
    integer
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end
