defmodule Extripe.Actions.Delete do
  alias Extripe.Utils.{API, Endpoint}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    resource = Keyword.fetch!(opts, :resource)

    code(scope, resource, Endpoint.scope_style(scope))
  end

  defp code(scope, resource, :no_scope_id) do
    quote do
      @spec delete(binary) :: {:ok, map} | {:error, binary}
      def delete(id) do
        API.delete(Endpoint.build(unquote(scope), nil, unquote(resource), id))
      end
    end
  end

  defp code(scope, resource, :with_scope_id) do
    quote do
      @spec delete(binary, binary) :: {:ok, map} | {:error, binary}
      def delete(scope_id, id) do
        API.delete(Endpoint.build(unquote(scope), scope_id, unquote(resource), id))
      end
    end
  end
end
