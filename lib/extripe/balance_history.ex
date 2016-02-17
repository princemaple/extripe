defmodule Extripe.BalanceHistory do
  use Extripe.Actions.CRUD, only: [:index, :show], scope: {"balance", :singular}, resource: "history"
end
