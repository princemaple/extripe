defmodule Extripe.Utils.Params do
  def normalize(map) do
    map
    |> Enum.filter(fn {_, v} -> !is_nil(v) end)
    |> normalize_containers([], [])
    |> Enum.map(&normalize_keys(&1, ""))
  end

  defp normalize_containers([], acc, _), do: acc

  defp normalize_containers(%{} = map, acc, keyspace) do
    normalize_containers(Enum.into(map, []), acc, keyspace)
  end

  defp normalize_containers([{k, v} | rest], acc, keyspace) do
    case v do
      [] ->
        normalize_containers(rest, acc, keyspace)
      x when is_list(x) or is_map(x) ->
        normalize_containers(rest, acc ++ normalize_containers(v, [], [k | keyspace]), keyspace)
      _ ->
        normalize_containers(rest, [{[k | keyspace], v} | acc], keyspace)
    end
  end

  defp normalize_containers([item | rest], acc, keyspace) do
    normalize_containers(rest, acc ++ normalize_containers(item, [], [:"[]" | keyspace]), keyspace)
  end

  defp normalize_containers(item, _, keyspace), do: [{keyspace, item}]

  defp normalize_keys({[key | []], value}, acc), do: {Atom.to_string(key) <> acc, value}
  defp normalize_keys({[key | keyspace], value}, acc) do
    case key do
      :"[]" -> normalize_keys({keyspace, value}, "[]" <> acc)
      _ -> normalize_keys({keyspace, value}, "[#{key}]" <> acc)
    end
  end
end
