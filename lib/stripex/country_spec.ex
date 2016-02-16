defmodule Stripex.CountrySpec do
  use Stripex.Actions.CRUD, only: [:index, :show]

  @resource "country_specs"
end
