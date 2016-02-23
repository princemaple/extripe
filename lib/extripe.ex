defmodule Extripe do
  @moduledoc ~S"""
  Extripe is a Stripe API wrapper that fully covers [all the v1 APIs](https://stripe.com/docs/api)

  If you found anything not covered, please feel free to
  [file an issue](https://github.com/princemaple/extripe/issues/new)
  or, even better, send a PR to add the missing piece.
  """
  def start, do: :application.ensure_all_started(:httpoison)
end
