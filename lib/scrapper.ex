defmodule Scrapper do
  @moduledoc """
  Main module that basically connects all the other modules together.
  """

  defmodule CLI do
    @moduledoc """
    Module that contains all the methods related to work with CLI
    """
    def main(args) do
      params =
        optimus_config()
        |> Optimus.parse!(args)

      Scrapper.scrap(params.args.words_file, params.args.output_file)
    end

    defp optimus_config() do
      Optimus.new!(
        name: "oxscrapper",
        description: "Oxford dictionary scrapper.",
        version: "0.0.1",
        author: "Ilia Kuzmin dargonaxxe@gmail.com",
        about:
          "Utility that scraps necessary data for specified words from Oxford dictionary website.",
        allow_unknown_args: false,
        parse_double_dash: false,
        args: [
          words_file: [
            value_name: "WORDS_FILE",
            help: "File with words of interest separated by semicolon",
            required: true,
            parser: :string
          ],
          output_file: [
            value_name: "OUTPUT_FILE",
            help: "Path to output .csv file",
            required: true,
            parser: :string
          ]
        ]
      )
    end
  end

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
