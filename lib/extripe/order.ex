defmodule Extripe.Order do
  use Extripe.Actions.CRUD, resource: "orders"

  alias Extripe.Utils.{API, Endpoint}

  @spec pay(id :: binary, customer_or_source :: Keyword.t)
    :: {:ok, map} | {:error, binary}
  def pay(id, customer: customer) do
    API.post(Endpoint.build(nil, nil, "orders", id) <> "/pay", %{customer: customer})
  end
  def pay(id, source: source) do
    API.post(Endpoint.build(nil, nil, "orders", id) <> "/pay", %{source: source})
  end
end
