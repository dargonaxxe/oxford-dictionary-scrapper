defmodule Oxford.LinkBuilder do
  @moduledoc """
  A module that contains functions for building oxford dictionary website links for specific words
  """

  def from_file!(path) do
    File.read!(path)
    |> String.split(";")
    |> Enum.map(&create/1)
  end

  def create(word) do
    "https://www.oxfordlearnersdictionaries.com/definition/english/#{word}"
  end
end
