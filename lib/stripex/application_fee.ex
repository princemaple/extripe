defmodule Stripex.ApplicationFee do
  use Stripex.Actions.CRUD, only: [:index, :show]

  @resource "application_fees"
end
