defmodule Extripe.Actions.Update do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def update(params), do: update(params.id, Map.delete(params, :id))
          def update(id, params), do: API.post(update_url(id), params)
          defp update_url(id) do
            Endpoint.build(unquote(scope), nil, unquote(resource), id)
          end
        end
      is_binary(scope) ->
        quote do
          def update(scope_id, params), do: update(scope_id, params.id, Map.delete(params, :id))
          def update(scope_id, id, params), do: API.post(update_url(scope_id, id), params)
          defp update_url(scope_id, id) do
            Endpoint.build(unquote(scope), scope_id, unquote(resource), id)
          end
        end
    end

    quote do
      unquote(code)
    end
  end
end
