defmodule Extripe.CountrySpec do
  use Extripe.Actions.CRUD, only: [:index, :show], resource: "country_specs"
end
