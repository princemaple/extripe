defmodule Extripe.Subscription do
  use Extripe.Actions.CRUD, except: [:delete], scope: "customers", resource: "subscriptions"

  alias Extripe.Utils.{API, Endpoint}

  @spec delete(binary) :: {:ok, map} | {:error, binary}
  def delete(id) do
    API.delete(Endpoint.build(nil, nil, "subscriptions", id))
  end
end
