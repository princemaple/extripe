defmodule Extripe.Mixfile do
  use Mix.Project

  @source_url "https://github.com/princemaple/extripe"
  @version "1.3.1"

  def project do
    [
      app: :extripe,
      version: @version,
      elixir: "~> 1.9",
      description: description(),
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "Extripe",
      canonical: "http://hexdocs.pm/extripe",
      source_url: @source_url
    ]
  end

  defp description do
    "Stripe API wrapper"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Po Chen"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
