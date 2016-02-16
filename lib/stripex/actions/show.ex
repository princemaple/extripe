defmodule Stripex.Actions.Show do
  alias Stripex.API

  defmacro __using__(_) do
    quote do
      def show(id), do: API.get("/#{@resource}" <> "/#{id}")
    end
  end
end
