# Extripe

Stripe API wrapper in Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add extripe to your list of dependencies in `mix.exs`:

        def deps do
          [{:extripe, "~> 0.1.0"}]
        end

  2. Ensure `httpoison` is started before your application:

        def application do
          [applications: [:httpoison]]
        end

