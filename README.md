# Extripe

Stripe API wrapper in Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add extripe to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:extripe, "~> 0.1.0"}]
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

##### Aliases

|original | alias  |
|---------|--------|
|index    | list   |
|show     | fetch  |
|create   | -      |
|update   | -      |
|delete   | destroy|


```elixir
iex(1)> Extripe.Plan.list
{:ok,
 %HTTPoison.Response{body: %{"data" => [%{"amount" => 1500,
       "created" => 1455733031, "currency" => "gbp", "id" => "regular_gb",
       "interval" => "month", "interval_count" => 1, "livemode" => false,
       "metadata" => %{}, "name" => "Regular GB", "object" => "plan",
       "statement_descriptor" => nil, "trial_period_days" => nil},
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
    "url" => "/v1/plans"},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:06:47 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "1080"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRWhttCzHLO4Y"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}
  
iex(2)> Extripe.Plan.show "regular"
{:ok,
 %HTTPoison.Response{body: %{"amount" => 1000, "created" => 1455593353,
    "currency" => "usd", "id" => "regular", "interval" => "month",
    "interval_count" => 1, "livemode" => false, "metadata" => %{},
    "name" => "REGULAR", "object" => "plan", "statement_descriptor" => nil,
    "trial_period_days" => 15},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:07:27 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "271"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRXXnO2BY4CJl"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}

iex(3)> Extripe.Plan.create %{id: "test", name: "My Test Plan", amount: 1999, interval: "month", currency: "usd"}
{:ok,
 %HTTPoison.Response{body: %{"amount" => 1999, "created" => 1455736111,
    "currency" => "usd", "id" => "test", "interval" => "month",
    "interval_count" => 1, "livemode" => false, "metadata" => %{},
    "name" => "My Test Plan", "object" => "plan", "statement_descriptor" => nil,
    "trial_period_days" => nil},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:08:31 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "275"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRYdALJHdxlyu"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}

# or Extripe.Plan.update "test", %{name: "MY TTTTEST PLAN"}
iex(4)> Extripe.Plan.update %{id: "test", name: "MY TTTTEST PLAN"}
{:ok,
 %HTTPoison.Response{body: %{"amount" => 1999, "created" => 1455736111,
    "currency" => "usd", "id" => "test", "interval" => "month",
    "interval_count" => 1, "livemode" => false, "metadata" => %{},
    "name" => "MY TTTTEST PLAN", "object" => "plan",
    "statement_descriptor" => nil, "trial_period_days" => nil},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:09:30 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "278"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRZxqVNJmsNjf"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}

iex(5)> Extripe.Plan.delete "test"
{:ok,
 %HTTPoison.Response{body: %{"deleted" => true, "id" => "test"},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:10:13 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "38"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRZRyGy3v1iaV"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}
```

#### Nested resources

```elixir
# find a customer first
iex(6)> Extripe.Customer.list
{:ok,
 %HTTPoison.Response{body: %{"data" => [%{"account_balance" => 0,
       "created" => 1455721994, "currency" => "usd", "default_source" => nil,
       "delinquent" => false, "description" => "test self", "discount" => nil,
       "email" => "chenpaul914@hotmail.com", "id" => "cus_7vNk0duWVulcPe",
       "livemode" => false, "metadata" => %{}, "object" => "customer",
       "shipping" => nil,
       "sources" => %{"data" => [], "has_more" => false, "object" => "list",
         "total_count" => 0,
         "url" => "/v1/customers/cus_7vNk0duWVulcPe/sources"},
       "subscriptions" => %{"data" => [], "has_more" => false,
         "object" => "list", "total_count" => 0,
         "url" => "/v1/customers/cus_7vNk0duWVulcPe/subscriptions"}}],
    "has_more" => false, "object" => "list", "url" => "/v1/customers"},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:11:50 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "852"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRbi0cEexsXrp"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}

# find the subscriptions that belong to the customer
iex(7)> Extripe.Subscription.list "cus_7vNk0duWVulcPe"
{:ok,
 %HTTPoison.Response{body: %{"data" => [], "has_more" => false,
    "object" => "list",
    "url" => "/v1/customers/cus_7vNk0duWVulcPe/subscriptions"},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:12:49 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "117"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRcc53AJGBG6t"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}

# manipulations...
iex(8)> Extripe.Subscription.create "cus_7vNk0duWVulcPe", %{plan: "regular"}
{:ok,
 %HTTPoison.Response{body: %{"application_fee_percent" => nil,
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
    "trial_start" => 1455736418},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:13:38 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "771"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRdiuiUhMxIzk"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}

iex(9)> Extripe.Subscription.delete "cus_7vNk0duWVulcPe", "sub_7vRdUiQQhv3M7u"
{:ok,
 %HTTPoison.Response{body: %{"application_fee_percent" => nil,
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
    "trial_start" => 1455736418},
  headers: [{"Server", "nginx"}, {"Date", "Wed, 17 Feb 2016 19:14:12 GMT"},
   {"Content-Type", "application/json"}, {"Content-Length", "783"},
   {"Connection", "keep-alive"}, {"Access-Control-Allow-Credentials", "true"},
   {"Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, DELETE"},
   {"Access-Control-Allow-Origin", "*"}, {"Access-Control-Max-Age", "300"},
   {"Cache-Control", "no-cache, no-store"},
   {"Request-Id", "req_7vRd9CAHJt8NE2"}, {"Stripe-Version", "2016-02-03"},
   {"Strict-Transport-Security", "max-age=31556926; includeSubDomains"}],
  status_code: 200}}
```

## Disclaimer

I've only started learning elixir a couple weeks ago.
