defmodule Extripe.Actions.Index do
  alias Extripe.Utils.{API, Endpoint}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, _opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def index do
            API.get(Endpoint.build(unquote(scope), nil, unquote(resource)))
          end
          defdelegate list, to: __MODULE__, as: :index
        end
      is_binary(scope) ->
        quote do
          def index(scope_id) do
            API.get(Endpoint.build(unquote(scope), scope_id, unquote(resource)))
          end
          defdelegate list(scope_id), to: __MODULE__, as: :index
        end
    end

    quote do
      unquote(code)
    end
  end
end
