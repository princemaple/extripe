defmodule Extripe.Actions.Index do
  alias Extripe.Utils.{API, Endpoint, Params}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    resource = Keyword.fetch!(opts, :resource)

    code(scope, resource, Endpoint.scope_style(scope))
  end

  defp code(scope, resource, :no_scope_id) do
    path = quote do: Endpoint.build(unquote(scope), nil, unquote(resource))

    quote do
      @spec index() :: {:ok, map} | {:error, binary}
      def index do
        API.get(unquote(path))
      end
      @spec index(map) :: {:ok, map} | {:error, binary}
      def index(opts) do
        query_string = URI.encode_query(Params.normalize(opts))
        API.get(unquote(path) <> "?" <> query_string)
      end
    end
  end

  defp code(scope, resource, :with_scope_id) do
    path = quote do: Endpoint.build(unquote(scope), scope_id, unquote(resource))

    quote do
      @spec index(binary) :: {:ok, map} | {:error, binary}
      def index(scope_id) do
        API.get(unquote(path))
      end
      @spec index(binary, map) :: {:ok, map} | {:error, binary}
      def index(scope_id, opts) do
        query_string = URI.encode_query(Params.normalize(opts))
        API.get(unquote(path) <> "?" <> query_string)
      end
    end
  end
end
