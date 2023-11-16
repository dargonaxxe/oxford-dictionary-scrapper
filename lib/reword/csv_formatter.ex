defmodule Reword.CsvFormatter do
  @moduledoc """
  A module that takes a file and converts it to csv format suitable for reword 
  application
  """

  def from_json(file_path, output) do
    result =
      File.read!(file_path)
      |> String.split("\n")
      |> Enum.map(&Jason.decode/1)
      |> Enum.filter(&valid?/1)
      |> Enum.map(fn {_, map} -> map end)
      |> Enum.map_join("\n", &to_csv/1)

    File.write(output, result)
  end

  defp to_csv(%{} = map) do
    word = map["word"] |> shield()
    phonetics = map["phonetics"] |> shield()
    definition = map["definition"] |> shield()
    examples = format_examples(map)
    format(word, phonetics, definition, examples)
  end

  defp format(word, phonetics, definition, "") do
    "#{word};#{phonetics};#{definition}"
  end

  defp format(word, phonetics, definition, examples) do
    "#{word};#{phonetics};#{definition};#{examples}"
  end

  defp shield(str), do: "\"#{str}\""

  defp format_examples(%{} = map) do
    map["examples"]
    |> Enum.map_join("", &"#{shield(&1)};#{shield("")};")
    |> String.trim_trailing(";")
  end

  defp valid?({:ok, _}), do: true
  defp valid?(_), do: false
end
