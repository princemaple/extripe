# Extripe

[![Hex.pm](https://img.shields.io/hexpm/v/extripe.svg)](https://hex.pm/packages/extripe)
[![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/extripe/Extripe.html)

Stripe API wrapper in Elixir [Read Documentation](http://hexdocs.pm/extripe/)

## Installation

  1. Add extripe to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:extripe, "~> 1.0"}]
end
```

  2. Ensure `httpoison` is started before your application:

```elixir
def application do
  [applications: [:httpoison]]
end
```

## Usage
Use with an env var `stripe_secret_key`

e.g.
```
stripe_secret_key=sk_test_abcdefg12345678 iex -S mix
```

### Features

#### Simple CRUD

Using `Plan`, `Customer` and `Subscirption` in the following examples, all entities should be supported, if you find anything that is not supported or new endpoints coming out from stripe, don't hesitate to [file an issue](https://github.com/princemaple/extripe/issues/new)

```elixir
iex(1)> Extripe.Plan.list
{:ok,
 %{"data" => [%{"amount" => 1500, "created" => 1455733031, "currency" => "gbp",
      "id" => "regular_gb", "interval" => "month", "interval_count" => 1,
      "livemode" => false, "metadata" => %{}, "name" => "Regular GB",
      "object" => "plan", "statement_descriptor" => nil,
      "trial_period_days" => nil},
    %{"amount" => 1000, "created" => 1455632453, "currency" => "aud",
      "id" => "regular_au", "interval" => "month", "interval_count" => 1,
      "livemode" => false, "metadata" => %{}, "name" => "Regular AU",
      "object" => "plan", "statement_descriptor" => nil,
      "trial_period_days" => 15},
    %{"amount" => 1000, "created" => 1455593353, "currency" => "usd",
      "id" => "regular", "interval" => "month", "interval_count" => 1,
      "livemode" => false, "metadata" => %{}, "name" => "REGULAR",
      "object" => "plan", "statement_descriptor" => nil,
      "trial_period_days" => 15}], "has_more" => false, "object" => "list",
   "url" => "/v1/plans"}}

iex(2)> Extripe.Plan.show "regular"
{:ok,
 %{"amount" => 1000, "created" => 1455593353, "currency" => "usd",
   "id" => "regular", "interval" => "month", "interval_count" => 1,
   "livemode" => false, "metadata" => %{}, "name" => "REGULAR",
   "object" => "plan", "statement_descriptor" => nil,
   "trial_period_days" => 15}}

iex(3)> Extripe.Plan.create %{id: "test", name: "My Test Plan", amount: 1999, interval: "month", currency: "usd"}
{:ok,
 %{"amount" => 1999, "created" => 1455736111,
   "currency" => "usd", "id" => "test", "interval" => "month",
   "interval_count" => 1, "livemode" => false, "metadata" => %{},
   "name" => "My Test Plan", "object" => "plan", "statement_descriptor" => nil,
   "trial_period_days" => nil}}

# or Extripe.Plan.update "test_id", %{name: "MY TTTTEST PLAN"}
iex(4)> Extripe.Plan.update %{id: "test_id", name: "MY TTTTEST PLAN"}
{:ok,
 %{"amount" => 1999, "created" => 1455736111,
   "currency" => "usd", "id" => "test", "interval" => "month",
   "interval_count" => 1, "livemode" => false, "metadata" => %{},
   "name" => "MY TTTTEST PLAN", "object" => "plan",
   "statement_descriptor" => nil, "trial_period_days" => nil}}

iex(5)> Extripe.Plan.delete "test"
{:ok, %{"deleted" => true, "id" => "test"}}
```

#### Nested resources

```elixir
# find a customer first
iex(6)> Extripe.Customer.list
{:ok,
 %{"data" => [%{"account_balance" => 0, "created" => 1455721994,
      "currency" => "usd", "default_source" => nil, "delinquent" => false,
      "description" => "test self", "discount" => nil,
      "email" => "chenpaul914@hotmail.com", "id" => "cus_7vNk0duWVulcPe",
      "livemode" => false, "metadata" => %{}, "object" => "customer",
      "shipping" => nil,
      "sources" => %{"data" => [], "has_more" => false, "object" => "list",
        "total_count" => 0,
        "url" => "/v1/customers/cus_7vNk0duWVulcPe/sources"},
      "subscriptions" => %{"data" => [], "has_more" => false,
        "object" => "list", "total_count" => 0,
        "url" => "/v1/customers/cus_7vNk0duWVulcPe/subscriptions"}}],
   "has_more" => false, "object" => "list", "url" => "/v1/customers"}}

# find the subscriptions that belong to the customer
iex(7)> Extripe.Subscription.list "cus_7vNk0duWVulcPe"
{:ok,
 %{"data" => [], "has_more" => false,
    "object" => "list",
    "url" => "/v1/customers/cus_7vNk0duWVulcPe/subscriptions"}}

# manipulations...
iex(8)> Extripe.Subscription.create "cus_7vNk0duWVulcPe", %{plan: "regular"}
{:ok,
 %{"application_fee_percent" => nil,
   "cancel_at_period_end" => false, "canceled_at" => nil,
   "current_period_end" => 1457032418, "current_period_start" => 1455736418,
   "customer" => "cus_7vNk0duWVulcPe", "discount" => nil, "ended_at" => nil,
   "id" => "sub_7vRdUiQQhv3M7u", "metadata" => %{}, "object" => "subscription",
   "plan" => %{"amount" => 1000, "created" => 1455593353, "currency" => "usd",
     "id" => "regular", "interval" => "month", "interval_count" => 1,
     "livemode" => false, "metadata" => %{}, "name" => "REGULAR",
     "object" => "plan", "statement_descriptor" => nil,
     "trial_period_days" => 15}, "quantity" => 1, "start" => 1455736418,
   "status" => "trialing", "tax_percent" => nil, "trial_end" => 1457032418,
   "trial_start" => 1455736418}}

iex(9)> Extripe.Subscription.delete "cus_7vNk0duWVulcPe", "sub_7vRdUiQQhv3M7u"
{:ok,
 %{"application_fee_percent" => nil,
   "cancel_at_period_end" => false, "canceled_at" => 1455736452,
   "current_period_end" => 1457032418, "current_period_start" => 1455736418,
   "customer" => "cus_7vNk0duWVulcPe", "discount" => nil,
   "ended_at" => 1455736452, "id" => "sub_7vRdUiQQhv3M7u", "metadata" => %{},
   "object" => "subscription",
   "plan" => %{"amount" => 1000, "created" => 1455593353, "currency" => "usd",
     "id" => "regular", "interval" => "month", "interval_count" => 1,
     "livemode" => false, "metadata" => %{}, "name" => "REGULAR",
     "object" => "plan", "statement_descriptor" => nil,
     "trial_period_days" => 15}, "quantity" => 1, "start" => 1455736418,
   "status" => "canceled", "tax_percent" => nil, "trial_end" => 1457032418,
   "trial_start" => 1455736418}}

iex(10)> Extripe.Subscription.show "cus_7vNk0duWVulcPe", "sub_7vRdUiQQhv3M7u"
{:ok,
 %{"error" => %{"message" => "Customer cus_7vNk0duWVulcPe does not have a subscription with ID sub_7vRdUiQQhv3M7u\n\n",
     "param" => "subscription", "type" => "invalid_request_error"}}}
```

#### Pagination

```elixir
iex(5)> Extripe.Plan.list starting_after: "regular_au"
{:ok,
 %{"data" => [%{"amount" => 1000, "created" => 1455593353, "currency" => "usd",
      "id" => "regular", "interval" => "month", "interval_count" => 1,
      "livemode" => false, "metadata" => %{}, "name" => "REGULAR",
      "object" => "plan", "statement_descriptor" => nil,
      "trial_period_days" => 15}], "has_more" => false, "object" => "list",
   "url" => "/v1/plans"}}

iex(6)> Extripe.Plan.list ending_before: "regular_au"
{:ok,
 %{"data" => [%{"amount" => 1500,
      "created" => 1455733031, "currency" => "gbp", "id" => "regular_gb",
      "interval" => "month", "interval_count" => 1, "livemode" => false,
      "metadata" => %{}, "name" => "Regular GB", "object" => "plan",
      "statement_descriptor" => nil, "trial_period_days" => nil}],
   "has_more" => false, "object" => "list", "url" => "/v1/plans"}}

iex(8)> Extripe.Plan.list limit: 1
{:ok,
 %{"data" => [%{"amount" => 1500,
      "created" => 1455733031, "currency" => "gbp", "id" => "regular_gb",
      "interval" => "month", "interval_count" => 1, "livemode" => false,
      "metadata" => %{}, "name" => "Regular GB", "object" => "plan",
      "statement_descriptor" => nil, "trial_period_days" => nil}],
   "has_more" => true, "object" => "list", "url" => "/v1/plans"}}

iex(9)> {:ok, events} = Extripe.Event.list created: [lt: 1455733031]
{:ok,
 %{"data" => [%{"api_version" => "2016-02-03", "created" => 1455732840,
      "data" => %{"object" => %{"amount" => 1000, "created" => 1455593353,
          "currency" => "usd", "id" => "regular", "interval" => "month",
          "interval_count" => 1, "livemode" => false, "metadata" => %{},
          "name" => "REGULAR", "object" => "plan",
          "statement_descriptor" => nil, "trial_period_days" => 15},
        "previous_attributes" => %{"name" => "Regular"}},
      "id" => "evt_17fZoKEhB5xMvgQ7Fdl7krpl", "livemode" => false,
      "object" => "event", "pending_webhooks" => 0,
      "request" => "req_7vQfTWcjfnH7JW", "type" => "plan.updated"},
    %{"api_version" => "2016-02-03", "created" => 1455732634,
      "data" => %{"object" => %{"amount" => 1500, "created" => 1455730831,
          "currency" => "gbp", "id" => "regular_gb", "interval" => "month",
          "interval_count" => 1, "livemode" => false, "metadata" => %{},
          "name" => "REGULAR GB", "object" => "plan",
          "statement_descriptor" => nil, "trial_period_days" => nil}},
      "id" => "evt_17fZl0EhB5xMvgQ7Ekqu42UQ", "livemode" => false,
      "object" => "event", "pending_webhooks" => 0,
      "request" => "req_7vQc2AYrZYzkv3", "type" => "plan.deleted"},
    %{"api_version" => "2016-02-03", "created" => 1455732348,
      "data" => %{"object" => %{"application_fee_percent" => nil,
          "cancel_at_period_end" => false, "canceled_at" => 1455732348,
          "current_period_end" => 1457027674,
          "current_period_start" => 1455731674,
          "customer" => "cus_7vNk0duWVulcPe", "discount" => nil,
          "ended_at" => 1455732348, "id" => "sub_7vQMcLg9Qvbuzn",
          "metadata" => %{}, "object" => "subscription",
          "plan" => %{"amount" => 1000, "created" => 1455593353,
            "currency" => "usd", "id" => "regular", "interval" => "month",
            "interval_count" => 1, "livemode" => false, "metadata" => %{},
            "name" => "Regular", "object" => "plan",
            "statement_descriptor" => nil, "trial_period_days" => 15},
          "quantity" => 1, "start" => 1455731674, "status" => "canceled",
          "tax_percent" => nil, "trial_end" => 1457027674,
          "trial_start" => 1455731674}}, "id" => "evt_17fZgOEhB5xMvgQ750S7kXaH",
      "livemode" => false, "object" => "event", "pending_webhooks" => 0,
      "request" => "req_7vQXJ6d8hVgjA5",
      "type" => "customer.subscription.deleted"},
    ...]}}

iex(10)> {:ok, events} = Extripe.Event.list created: [gt: 1455733031]
# similar to iex(9)
# and you also have gte, lte
# or you could just specify an integer unix timestamp for :created instead of a map or a keyword list
```

## Contributing

```elixir
# Adding a new resource
defmodule Extripe.NewResource do
  # normal resource
  # note: new_resource is probably plural
  use Extripe.Actions.CRUD, resource: "new_resource"

  # not fully CRUDable resource
  use Extripe.Actions.CRUD, only: [:index, :show], resource: "new_resource"
  # or
  use Extripe.Actions.CRUD, except: [:delete], resource: "new_resource"

  # nested resource
  # when the scoping resource is plural, e.g. /v1/customers/customer_id/subscriptions
  use Extripe.Actions.CRUD, scope: "customers", resource: "subscriptions"
  # when the scoping resource is singular, e.g. /v1/balance/history
  use Extripe.Actions.CRUD, scope: {"balance", :singular}, resource: "history"

  # singluar resource
  # currently only Balance is of this kind, /v1/balance
  use Extripe.Actions.CRUD, only: [:show], resource: "balance", singular: true

  # special case implementations
  def pay(id), do: # pay bill

  # special CRUD implementations
  def list do
    # special implementation of list
  end
end
```
