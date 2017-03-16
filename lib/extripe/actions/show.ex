defmodule Extripe.Actions.Show do
  alias Extripe.Utils.{API, Endpoint}

  defmacro __using__(opts) do
    {scope, opts} = Keyword.pop(opts, :scope)
    {singular, opts} = Keyword.pop(opts, :singular, false)
    resource = Keyword.fetch!(opts, :resource)

    has_scope_id = case scope do
      <<_scope::binary>> -> true
      {_scope, :singular} -> false
      nil -> false
    end

    cond do
      singular && !has_scope_id ->
        quote do
          def show do
            API.get(Endpoint.build(unquote(scope), nil, unquote(resource)))
          end
        end
      singular && has_scope_id ->
        quote do
          def show(scope_id) do
            API.get(Endpoint.build(unquote(scope), scope_id, unquote(resource)))
          end
        end
      !has_scope_id ->
        quote do
          def show(id) do
            API.get(Endpoint.build(unquote(scope), nil, unquote(resource), id))
          end
        end
       has_scope_id ->
        quote do
          def show(scope_id, id) do
            API.get(Endpoint.build(unquote(scope), scope_id, unquote(resource), id))
          end
        end
    end
  end
end
