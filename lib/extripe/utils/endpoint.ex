defmodule Extripe.Utils.Endpoint do
  def code_style(nil), do: :no_scope_id
  def code_style({_name, :singular}), do: :no_scope_id
  def code_style(name) when is_binary(name), do: :with_scope_id

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
      unquote(__MODULE__).build(
        unquote(scope),
        unquote(scope_id),
        unquote(resource)
      ) <> "/#{unquote(id)}"
    end
  end
end
