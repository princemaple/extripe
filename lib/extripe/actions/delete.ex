defmodule Extripe.Actions.Delete do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, _opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def delete(id) do
            API.delete(Endpoint.build(unquote(scope), nil, unquote(resource), id))
          end
          defdelegate destroy(id), to: __MODULE__, as: :delete
        end
      is_binary(scope) ->
        quote do
          def delete(scope_id, id) do
            API.delete(Endpoint.build(unquote(scope), scope_id, unquote(resource), id))
          end
          defdelegate destroy(scope_id, id), to: __MODULE__, as: :delete
        end
    end

    quote do
      unquote(code)
    end
  end
end
