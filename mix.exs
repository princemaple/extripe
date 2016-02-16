defmodule Stripex.Mixfile do
  use Mix.Project

  def project do
    [app: :stripex,
     version: "0.1.0",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.8.0"},
     {:poison, "~> 2.1.0"}]
  end

  defp description do
    "Stripe API wrapper"
  end

  defp package do
    [files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Po Chen"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/princemaple/stripex"}]
  end
end
