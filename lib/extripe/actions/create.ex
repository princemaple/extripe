defmodule Extripe.Actions.Create do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def create(params), do: API.post(create_url, params)
          defp create_url do
            Endpoint.build(unquote(scope), nil, unquote(resource))
          end
        end
      is_binary(scope) ->
        quote do
          def create(scope_id, params), do: API.post(create_url(scope_id), params)
          defp create_url(scope_id) do
            Endpoint.build(unquote(scope), scope_id, unquote(resource))
          end
        end
    end

    quote do
      unquote(code)
    end
  end
end
