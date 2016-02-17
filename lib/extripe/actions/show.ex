defmodule Extripe.Actions.Show do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def show(id), do: API.get(show_url(id))
          defdelegate fetch(id), to: __MODULE__, as: :show
          defp show_url(id) do
            Endpoint.build(unquote(scope), nil, unquote(resource), id)
          end
        end
      is_binary(scope) ->
        quote do
          def show(scope_id, id), do: API.get(show_url(scope_id, id))
          defdelegate fetch(scope_id, id), to: __MODULE__, as: :show
          defp show_url(scope_id, id) do
            Endpoint.build(unquote(scope), scope_id, unquote(resource), id)
          end
        end
    end

    quote do
      unquote(code)
    end
  end
end
