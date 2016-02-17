defmodule Extripe.Utils.Endpoint do
  alias __MODULE__

  defmacro build(scope, scope_id, resource) do
    case scope do
      nil ->
        quote do
          unquote("/#{resource}")
        end
      {scope, :singular} when is_binary(scope) ->
        quote do
          unquote("/#{scope}") <> unquote("/#{resource}")
        end
      scope when is_binary(scope) ->
        quote do
          unquote("/#{scope}/") <> unquote(scope_id) <> unquote("/#{resource}")
        end
    end
  end

  defmacro build(scope, scope_id, resource, id) do
    quote do
      Endpoint.build(
        unquote(scope),
        unquote(scope_id),
        unquote(resource)
      ) <> "/#{unquote(id)}"
    end
  end
end
