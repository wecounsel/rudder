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

## Todos

- [x] implement identify request
- [x] implement track request
- [x] implement page request
- [ ] implement alias request
- [ ] implement screen request
- [ ] implement group request
- [ ] implement merge request
- [ ] implement batch request

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rudder>.
