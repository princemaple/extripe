defmodule Extripe.Utils.Endpoint do
  def scope_style(nil), do: :no_scope_id
  def scope_style({_name, :singular}), do: :no_scope_id
  def scope_style(name) when is_binary(name), do: :with_scope_id

  defmacro build(nil, _scope_id, resource) do
    quote do
      unquote("/#{resource}")
    end
  end
  defmacro build({scope, :singular}, _scope_id, resource) do
    quote do
      unquote("/#{scope}") <> unquote("/#{resource}")
    end
  end
  defmacro build(scope, scope_id, resource) do
    quote do
      unquote("/#{scope}/") <> unquote(scope_id) <> unquote("/#{resource}")
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
