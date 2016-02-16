defmodule Stripex.Event do
  use Stripex.Actions.CRUD, only: [:index, :show]

  @resource "events"
end
