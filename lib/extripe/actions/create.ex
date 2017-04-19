defmodule Extripe.Actions.Create do
  alias Extripe.Utils.{API, Endpoint}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    resource = Keyword.fetch!(opts, :resource)

    code(scope, resource, Endpoint.scope_style(scope))
  end

  defp code(scope, resource, :no_scope_id) do
    quote do
      @spec create(map) :: {:ok, map} | {:error, binary}
      def create(params) do
        API.post(Endpoint.build(unquote(scope), nil, unquote(resource)), params)
      end
    end
  end

  defp code(scope, resource, :with_scope_id) do
    quote do
      @spec create(binary, map) :: {:ok, map} | {:error, binary}
      def create(scope_id, params) do
        API.post(Endpoint.build(unquote(scope), scope_id, unquote(resource)), params)
      end
    end
  end
end
