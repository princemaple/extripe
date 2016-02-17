defmodule Extripe.Transfer do
  use Extripe.Actions.CRUD, except: [:delete], resource: "transfers"
end
