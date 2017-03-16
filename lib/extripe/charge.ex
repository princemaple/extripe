defmodule Extripe.Charge do
  use Extripe.Actions.CRUD, resource: "charges"

  alias Extripe.Utils.{API, Endpoint}

  @spec capture(id :: binary) :: {:ok, map} | {:error, binary}
  def capture(id) do
    API.post(Endpoint.build(nil, nil, "charges", id) <> "/capture", "")
  end
end
