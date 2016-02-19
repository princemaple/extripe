defmodule Extripe.Utils.API do
  use HTTPoison.Base

  defp process_url(url) do
    "https://"
    <> System.get_env("stripe_secret_key")
    <> ":@api.stripe.com/v1"
    <> url
  end

  defp process_request_body(body) when is_binary(body), do: body
  defp process_request_body(body) do
    body
    |> Extripe.Utils.Params.normalize
    |> URI.encode_query
  end

  defp process_request_headers(headers) do
    [{"content-type", "application/x-www-form-urlencoded"} | headers]
  end

  defp process_response_body(body) do
    Poison.decode! body
  end
end
