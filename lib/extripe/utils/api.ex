defmodule Extripe.Utils.API do
  use HTTPoison.Base

  defp process_url(url) do
    [
      "https://",
      Application.get_env(
        :extripe,
        :stripe_secret_key,
        System.get_env("stripe_secret_key")
      ),
     ":@api.stripe.com/v1",
     url
   ]
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

  def get(url), do: super(url) |> ok_error
  def post(url, body), do: super(url, body) |> ok_error
  def delete(url), do: super(url) |> ok_error

  defp ok_error({:ok, %{body: %{"error" => error}}}), do: {:error, error}
  defp ok_error({:ok, %{body: body}}), do: {:ok, body}
  defp ok_error({:error, %{reason: reason}}), do: {:error, reason}
end
