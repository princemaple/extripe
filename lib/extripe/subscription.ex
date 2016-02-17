defmodule Extripe.Subscription do
  use Extripe.Actions.CRUD, scope: "customers", resource: "subscriptions"
end
