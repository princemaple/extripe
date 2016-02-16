defmodule Stripex.Actions.CRUD do
  @actions [:index, :show, :create, :update, :delete]

  defmacro __using__(opts) do
    actions = Keyword.get(opts, :only, @actions)
    actions = actions -- Keyword.get(opts, :except, [])

    compile(actions)
  end

  defp compile(actions) do
    compile(actions, [])
  end

  defp compile([:index|rest], acc) do
    compile(rest, [quote(do: use Stripex.Actions.Index) | acc])
  end
  defp compile([:show|rest], acc) do
    compile(rest, [quote(do: use Stripex.Actions.Show) | acc])
  end
  defp compile([:create|rest], acc) do
    compile(rest, [quote(do: use Stripex.Actions.Create) | acc])
  end
  defp compile([:update|rest], acc) do
    compile(rest, [quote(do: use Stripex.Actions.Update) | acc])
  end
  defp compile([:delete|rest], acc) do
    compile(rest, [quote(do: use Stripex.Actions.Delete) | acc])
  end

  defp compile([], acc) do
    acc
  end
end
