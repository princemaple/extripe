defmodule Extripe do
  def start, do: :application.ensure_all_started(:httpoison)
end
