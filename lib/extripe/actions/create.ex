defmodule Extripe.Actions.Create do
  alias Extripe.API
  alias Extripe.Utils.Endpoint

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {resource, opts} = Keyword.pop(opts, :resource)

    code = cond do
      is_tuple(scope) or is_nil(scope) ->
        quote do
          def create(params) do
            API.post(Endpoint.build(unquote(scope), nil, unquote(resource)), params)
          end
        end
      is_binary(scope) ->
        quote do
          def create(scope_id, params) do
            API.post(Endpoint.build(unquote(scope), scope_id, unquote(resource)), params)
          end
        end
    end

    quote do
      unquote(code)
    end
  end
end
