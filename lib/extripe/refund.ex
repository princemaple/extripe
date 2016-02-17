defmodule Extripe.Refund do
  use Extripe.Actions.CRUD, except: [:create, :delete], resource: "refunds"

  # TODO #create is scoped
end
