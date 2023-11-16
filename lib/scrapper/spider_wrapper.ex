defmodule Scrapper.SpiderWrapper do
  @moduledoc """
  A module that contains functions that help with spider-related work
  """

  @spider Oxford.Spider

  @doc """
  This function delays until the spider with given name does not lack requests 
  for 3 or more seconds. When this happens, returns :ok 
  """
  def wait_for_spider(name \\ @spider, acc \\ 0)
  def wait_for_spider(_, 3), do: :ok

  def wait_for_spider(name, acc) do
    Process.sleep(1000)

    case Crawly.RequestsStorage.stats(name) do
      {:error, _} ->
        :ok

      {_, 0} ->
        wait_for_spider(name, acc + 1)

      {_, _} ->
        wait_for_spider(name)
    end
  end
end
