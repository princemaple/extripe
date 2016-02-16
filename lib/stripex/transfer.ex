defmodule Stripex.Transfer do
  use Stripex.Actions.CRUD, except: [:delete]

  @resource "transfers"
end
