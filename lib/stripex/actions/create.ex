defmodule Stripex.Actions.Create do
  alias Stripex.API

  defmacro __using__(_) do
    quote do
      def create(params), do: API.post("/#{@resource}", params)
    end
  end
end
