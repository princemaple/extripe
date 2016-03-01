defmodule Extripe.Refund do
  use Extripe.Actions.CRUD, except: [:delete], resource: "refunds"
end
