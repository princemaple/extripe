defmodule Extripe.Source do
  use Extripe.Actions.CRUD, only: [:create, :show], resource: "sources"
end
