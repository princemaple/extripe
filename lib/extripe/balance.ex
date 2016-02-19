defmodule Extripe.Balance do
  use Extripe.Actions.CRUD, only: [:show], resource: "balance", singular: true
end
