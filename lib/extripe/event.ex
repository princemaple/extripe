defmodule Extripe.Event do
  use Extripe.Actions.CRUD, only: [:index, :show]

  @resource "events"
end
