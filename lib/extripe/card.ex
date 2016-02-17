defmodule Extripe.Card do
  use Extripe.Actions.CRUD, except: [:index], scope: "customers", resource: "sources"

  # TODO #list
end
