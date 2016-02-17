defmodule Extripe.ApplicationFee do
  use Extripe.Actions.CRUD, only: [:index, :show], resource: "application_fees"
end
