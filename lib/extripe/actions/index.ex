defmodule Extripe.Actions.Index do
  alias Extripe.Utils.{API, Endpoint, Params}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, _opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        path = quote do: Endpoint.build(unquote(scope), nil, unquote(resource))

        quote do
          def index do
            API.get(unquote(path))
          end
          def index(opts) do
            query_string = URI.encode_query(Params.normalize(opts))
            API.get(unquote(path) <> "?" <> query_string)
          end
          defdelegate list, to: __MODULE__, as: :index
          defdelegate list(opts), to: __MODULE__, as: :index
        end
      is_binary(scope) ->
        path = quote do: Endpoint.build(unquote(scope), scope_id, unquote(resource))

        quote do
          def index(scope_id) do
            API.get(unquote(path))
          end
          def index(scope_id, opts) do
            query_string = URI.encode_query(Params.normalize(opts))
            API.get(unquote(path) <> "?" <> query_string)
          end
          defdelegate list(scope_id), to: __MODULE__, as: :index
          defdelegate list(scope_id, opts), to: __MODULE__, as: :index
        end
    end

    quote do
      unquote(code)
    end
  end
end
