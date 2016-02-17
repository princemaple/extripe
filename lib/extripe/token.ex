defmodule Extripe.Token do
  use Extripe.Actions.CRUD, only: [:show, :create], resource: "tokens"
end
