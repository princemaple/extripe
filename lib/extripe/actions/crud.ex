defmodule Extripe.Actions.CRUD do
  @actions [:index, :show, :create, :update, :delete]

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

  defp compile(actions) do
    compile(actions, [])
  end

  defp compile([:index|rest], acc) do
    compile(rest, [quote(do: use Extripe.Actions.Index) | acc])
  end
  defp compile([:show|rest], acc) do
    compile(rest, [quote(do: use Extripe.Actions.Show) | acc])
  end
  defp compile([:create|rest], acc) do
    compile(rest, [quote(do: use Extripe.Actions.Create) | acc])
  end
  defp compile([:update|rest], acc) do
    compile(rest, [quote(do: use Extripe.Actions.Update) | acc])
  end
  defp compile([:delete|rest], acc) do
    compile(rest, [quote(do: use Extripe.Actions.Delete) | acc])
  end

  defp compile([], acc) do
    acc
  end
end
