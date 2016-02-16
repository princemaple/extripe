defmodule Stripex.API do
  use HTTPoison.Base

  defp process_url(url) do
    "https://"
    <> System.get_env("stripe_secret_key")
    <> ":@api.stripe.com/v1"
    <> url
  end

  defp process_request_body(body) when is_binary(body), do: body
  defp process_request_body(body) do
    import Stripex.Utils, only: [normalize_params: 1]

    body
    |> Map.from_struct
    |> normalize_params
    |> URI.encode_query
  end

  defp process_request_headers(headers) do
    [{"content-type", "application/x-www-form-urlencoded"} | headers]
  end

  def decode!(module, json) do
    json
    |> Poison.decode!
    |> fetch_data
    |> to_struct(module)
  end

  defp fetch_data(map) do
    case Map.fetch(map, "data") do
      {:ok, data} -> data
      :error -> map
    end
  end

  defp to_struct(maps, module) when is_list(maps) do
    Enum.map(maps, &to_struct(&1, module))
  end

  defp to_struct(map, module) do
    struct(module, atomize_keys(map))
  end

  defp atomize_keys(map) do
    Enum.map(map, fn {k, v} -> {String.to_atom(k), v} end)
  end
end
