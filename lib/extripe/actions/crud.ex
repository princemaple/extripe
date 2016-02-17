defmodule Extripe.Actions.CRUD do
  import String, only: [capitalize: 1, to_atom: 1]

  @actions [:index, :show, :create, :update, :delete]
  @action_implementations Enum.map(@actions, fn action ->
    {action, to_atom "Elixir.Extripe.Actions.#{action |> to_string |> capitalize}"}
  end)

  defmacro __using__(opts) do
    actions = Keyword.get(opts, :only, @actions)
    actions = actions -- Keyword.get(opts, :except, [])

    quote do
      Module.put_attribute __MODULE__, :crud_actions, unquote(actions)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    compile(Module.get_attribute(env.module, :crud_actions))
  end

  defp which_implementation(action), do: @action_implementations[action]

  defp compile(actions) do
    compile(actions, [])
  end

  for action <- @actions do
    defp compile([unquote(action) = action | rest], acc) do
      compile(rest, [quote do
        use unquote(which_implementation(action))
      end | acc])
    end
  end

  defp compile([], acc) do
    acc
  end
end
