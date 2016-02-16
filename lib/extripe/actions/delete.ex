defmodule Extripe.Actions.Delete do
  alias Extripe.API

  defmacro __using__(_) do
    quote do
      def delete(id) when is_binary(id) do
        API.delete("/#{@resource}" <> "/#{id}")
      end

      def delete(params) when is_map(params) do
        API.delete("/#{@resource}" <> "/#{params.id}")
      end
    end
  end
end
