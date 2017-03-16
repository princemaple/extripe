defmodule Extripe.Dispute do
  use Extripe.Actions.CRUD, resource: "disputes"

  alias Extripe.Utils.{API, Endpoint}

  @spec close(id :: binary) :: {:ok, map} | {:error, binary}
  def close(id) do
    API.post(Endpoint.build(nil, nil, "disputes", id) <> "/close", "")
  end
end
