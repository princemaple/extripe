defmodule Stripex.Token do
  use Stripex.Actions.CRUD, only: [:show, :create]

  @resource "tokens"
end
