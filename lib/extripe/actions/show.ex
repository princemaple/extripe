defmodule Extripe.Actions.Show do
  alias Extripe.API

  defmacro __using__(_) do
    quote do
      def show(id), do: API.get("/#{@resource}" <> "/#{id}")
    end
  end
end
