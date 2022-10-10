# Rudder

Elixir package for interacting with RudderStack HTTP API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rudder` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rudder, "~> 0.1.0"}
  ]
end
```

## Create a client

```elixir
client = Rudder.Client.new(write_key: "abc123", data_plane_url: "https://example.com")
```

## Identify

```elixir
Rudder.identify(client, %Rudder.Identity{
  user_id: "123",
  context: %{ip: '10.81.20.10'},
  traits: %{email: user.email }
})
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#5-identify)

## Track

```elixir
Rudder.track(client, %Rudder.Event{
  user_id: "123",
  name: "Item Sold",
  properties: %{ revenue: 9.95, shipping: 'Free'}
})
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#6-track)

## Page

```elixir
Rudder.page(client, %Rudder.Page{
  user_id: "123",
  name: "Page View",
  properties: %{title: "Home", path: "/"}
})
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#7-page)

## Screen

```elixir
Rudder.screen(client, %Rudder.Screen{
  user_id: "123",
  name: "Screen View",
  properties: %{prop1: "5"}
})
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#8-screen)

## Group

```elixir
Rudder.group(client, %Rudder.group{
  user_id: "123",
  group_id: "group-a",
  traits: %{
    name: "Company",
    industry: "Industry",
    employees: 123
  },
  context: %{
    ip: "14.5.67.21"
  }
})
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#9-group)

## Alias

```elixir
Rudder.alias(client, %Rudder.Alias{
  user_id: "123",
  previous_id: "456",
  context: %{
    traits: %{
      trait1: "new-val"
    },
    ip: "14.5.67.21"
  }
})

```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#10-alias)

## Merge

```elixir
Rudder.merge(client, %Rudder.Merge{
  user_id: "123",
  merge_properties: [
    %{type: "email", value: "someone@example.com"},
    %{type: "mobile", value: "+15555552263"}
})
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#11-merge)

## Batch

```elixir
Rudder.batch(client, %Rudder.Batch{
  items: [
    %Rudder.Identity{
      user_id: "123",
      context: %{ip: '10.81.20.10'},
      traits: %{email: user.email }
    },
    %Rudder.Page{
      user_id: "123",
      name: "Page View",
      properties: %{title: "Home", path: "/"}
    }
  ]
)
```

See [Docs](https://www.rudderstack.com/docs/api/http-api/#12-batch)

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rudder>.
