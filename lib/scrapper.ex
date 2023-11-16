defmodule Scrapper do
  @moduledoc """
  Main module that basically connects all the other modules together.
  """

  @spider Oxford.Spider
  def scrap(words_file, output_file) do
    urls = Oxford.LinkBuilder.from_file!(words_file)
    :ok = Crawly.Engine.start_spider(@spider, urls: urls)

    {:ok, id} = Crawly.Engine.get_crawl_id(@spider)
    :ok = Scrapper.SpiderWrapper.wait_for_spider()

    :ok =
      spider_report_file(id)
      |> Reword.CsvFormatter.from_json(output_file)
  end

  defp spider_report_file(id) do
    output_directory = Application.get_env(:scrapper, :output_directory)
    "#{output_directory}/Oxford.Spider_#{id}.json"
  end
end
