defmodule Scrapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :scrapper,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Scrapper.CLI]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Scrapper.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:crawly, "0.16.0"},
      {:floki, "0.35.2"},
      {:credo, "1.7.1", only: [:dev, :test], runtime: false},
      {:jason, "1.4.1"},
      {:optimus, "0.5.0"}
    ]
  end
end
