defmodule Extripe.Actions.CRUD do
  import String, only: [capitalize: 1, to_atom: 1]

  @actions [:index, :show, :create, :update, :delete]
  @action_implementations Enum.map(@actions, fn action ->
    {action, to_atom "Elixir.Extripe.Actions.#{action |> to_string |> capitalize}"}
  end)

  defmacro __using__(opts) do
    actions = Keyword.get(opts, :only, @actions)
    actions = actions -- Keyword.get(opts, :except, [])
    opts = Keyword.drop(opts, [:only, :except])

    quote do
      require Extripe.Utils.Endpoint
      Module.put_attribute __MODULE__, :crud_actions, unquote(actions)
      Module.put_attribute __MODULE__, :endpoint_opts, unquote(opts)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    compile(
      Module.get_attribute(env.module, :crud_actions),
      Module.get_attribute(env.module, :endpoint_opts)
    )
  end

  defp which_implementation(action), do: @action_implementations[action]

  defp compile(actions, opts) do
    compile(actions, opts, [])
  end

  for action <- @actions do
    defp compile([unquote(action) = action | rest], opts, acc) do
      compile(rest, opts, [quote do
        use unquote(which_implementation(action)), unquote(opts)
      end | acc])
    end
  end

  defp compile([], _, acc) do
    acc
  end
end
