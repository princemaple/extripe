defmodule Extripe.Actions.CRUD do
  @actions [:index, :show, :create, :update, :delete]
  @action_implementations Enum.map(@actions, fn action ->
    {action, Module.concat(Extripe.Actions, action |> to_string |> Macro.camelize)}
  end)

  defmacro __using__(opts) do
    actions = Keyword.pop(opts, :only, @actions)
    actions = actions -- Keyword.pop(opts, :except, [])
    resource = Keyword.fetch!(opts, :resource)

    quote do
      @moduledoc ~s"""
      See [Stripe API reference](https://stripe.com/docs/api##{unquote(resource)})
      for more information about #{__MODULE__ |> Module.split |> List.last}
      """
      require Extripe.Utils.Endpoint
      unquote(compile(actions, opts))
    end
  end

  defp compile(actions, opts, acc \\ [])

  defp compile([], _, acc), do: acc

  for action <- @actions do
    defp compile([unquote(action) = action | rest], opts, acc) do
      compile(rest, opts, [quote do
        use unquote(@action_implementations[action]), unquote(opts)
      end | acc])
    end
  end
end
