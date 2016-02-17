defmodule Extripe.ApplicationFeeRefund do
  use Extripe.Actions.CRUD, except: [:delete], scope: "application_fees", resource: "refunds"
end
