defmodule Stripex.Actions.Index do
  alias Stripex.API

  defmacro __using__(_) do
    quote do
      def index, do: API.get("/#{@resource}")
      def list, do: API.get("/#{@resource}")
    end
  end
end
