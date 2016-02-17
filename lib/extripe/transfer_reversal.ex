defmodule Extripe.TransferReversal do
  use Extripe.Actions.CRUD, except: [:delete], scope: "transfers", resource: "reversals"
end
