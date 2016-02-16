defmodule Extripe.Actions.Create do
  alias Extripe.API

  defmacro __using__(_) do
    quote do
      def create(params), do: API.post("/#{@resource}", params)
    end
  end
end
