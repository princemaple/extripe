defmodule Stripex.Refund do
  use Stripex.Actions.CRUD, except: [:delete]

  @resource "refunds"
end
