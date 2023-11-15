defmodule Oxford.Spider do
  @moduledoc """
  Basic spider that scraps word definition and examples from oxford dictionary 
  """
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url() do
    "https://www.oxfordlearnersdictionaries.com/"
  end

  @impl Crawly.Spider
  def init() do
    {:error, :no_words}
  end

  @impl Crawly.Spider
  def init(params) do
    [start_urls: params[:urls]]
  end

  def parse_item(%HTTPoison.Response{status_code: 200} = response) do
    %{items: get_items(response)}
  end

  defp get_items(%HTTPoison.Response{} = response) do
    {:ok, document} = Floki.parse_document(response.body)

    entry = Floki.find(document, "div.main-container")

    word = get_word(entry)

    phonetics = get_phonetics(entry)

    get_items(word, phonetics, entry)
  end

  defp get_items(word, phonetics, entry) do
    Floki.find(entry, "li.sense")
    |> Enum.map(&{get_definition(&1), get_examples(&1)})
    |> Enum.map(fn {x, y} ->
      %{
        word: word,
        phonetics: phonetics,
        definition: x,
        examples: y
      }
    end)
  end

  defp get_definition(sense) do
    Floki.find(sense, "span.def")
    |> Floki.text()
  end

  defp get_phonetics(entry) do
    Floki.find(entry, "div.phons_n_am")
    |> Floki.find("span.phon")
    |> Floki.text()
  end

  defp get_word(entry) do
    Floki.find(entry, "h1.headword")
    |> Floki.text()
  end

  defp get_examples(sense) do
    Floki.find(sense, "ul.examples")
    |> Floki.find("span.x")
    |> Enum.map(fn y -> Floki.text(y) end)
  end

  def parse_item(%HTTPoison.Response{status_code: 302} = response) do
    result = Enum.find(response.headers, nil, fn {x, y} -> x == "Location" end)

    case result do
      {_, location} ->
        request = Crawly.Utils.request_from_url(location)
        %Crawly.ParsedItem{items: [], requests: [request]}

      nil ->
        %{}
    end
  end

  # todo: handle 404 
  # todo: log failed requests
  @impl Crawly.Spider
  def parse_item(%HTTPoison.Response{} = response) do
    %Crawly.ParsedItem{items: [], requests: []}
  end
end
