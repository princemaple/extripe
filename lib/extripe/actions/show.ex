defmodule Extripe.Actions.Show do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, _opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def show(id) do
            API.get(Endpoint.build(unquote(scope), nil, unquote(resource), id))
          end
          defdelegate fetch(id), to: __MODULE__, as: :show
        end
      is_binary(scope) ->
        quote do
          def show(scope_id, id) do
            API.get(Endpoint.build(unquote(scope), scope_id, unquote(resource), id))
          end
          defdelegate fetch(scope_id, id), to: __MODULE__, as: :show
        end
    end

    quote do
      unquote(code)
    end
  end
end
