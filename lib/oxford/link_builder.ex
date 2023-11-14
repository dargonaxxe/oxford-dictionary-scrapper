defmodule Oxford.LinkBuilder do
  @moduledoc """
  A module that contains functions for building oxford dictionary website links for specific words
  """

  def create(word) do
    "https://www.oxfordlearnersdictionaries.com/definition/english/#{word}"
  end
end
