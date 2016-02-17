defmodule Extripe.Actions.Index do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def index, do: API.get(index_url)
          defdelegate list, to: __MODULE__, as: :index
          defp index_url do
            Endpoint.build(unquote(scope), nil, unquote(resource))
          end
        end
      is_binary(scope) ->
        quote do
          def index(scope_id), do: API.get(index_url(scope_id))
          defdelegate list(scope_id), to: __MODULE__, as: :index
          defp index_url(scope_id) do
            Endpoint.build(unquote(scope), scope_id, unquote(resource))
          end
        end
    end

    quote do
      unquote(code)
    end
  end
end
