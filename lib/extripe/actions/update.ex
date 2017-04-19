defmodule Extripe.Actions.Update do
  alias Extripe.Utils.{API, Endpoint}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    resource = Keyword.fetch!(opts, :resource)

    code(scope, resource, Endpoint.scope_style(scope))
  end

  defp code(scope, resource, :no_scope_id) do
    quote do
      @spec update(map) :: {:ok, map} | {:error, binary}
      def update(params), do: update(params.id, Map.delete(params, :id))

      @spec update(binary, map) :: {:ok, map} | {:error, binary}
      def update(id, params) do
        API.post(Endpoint.build(unquote(scope), nil, unquote(resource), id), params)
      end
    end
  end

  defp code(scope, resource, :with_scope_id) do
    quote do
      @spec update(binary, map) :: {:ok, map} | {:error, binary}
      def update(scope_id, params), do: update(scope_id, params.id, Map.delete(params, :id))

      @spec update(binary, binary, map) :: {:ok, map} | {:error, binary}
      def update(scope_id, id, params) do
        API.post(Endpoint.build(unquote(scope), scope_id, unquote(resource), id), params)
      end
    end
  end
end
