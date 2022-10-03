defmodule RudderTest do
  use ExUnit.Case
  doctest Rudder
  import Mock

  alias RudderClient
  alias Rudder.{Client, Identity, Request, Event, Result}

  setup do
    client = Client.new(write_key: "123", data_plane_url: "https://api.example.com")
    {:ok, client: client}
  end

  describe "identify/2" do
    setup(_) do
      identity = %Identity{
        user_id: "123",
        timestamp: "2022-09-24T08:25:57.589182Z"
      }

      {:ok, identity: identity}
    end

    test "sends request to client", %{client: client, identity: identity} do
      with_mock Client, send: fn _client, _identity -> {:ok, %Result{success: true}} end do
        Rudder.identify(client, identity)

        assert_called_exactly(
          Client.send(client, %Rudder.Request{
            method: :post,
            params: %{
              anonymousId: "",
              context: %{library: %{name: "Rudder"}},
              integrations: %{},
              timestamp: "2022-09-24T08:25:57.589182Z",
              traits: %{},
              userId: "123"
            },
            uri: "v1/identify"
          }),
          1
        )
      end
    end
  end

  describe "track/2" do
    setup(_) do
      event = %Event{
        user_id: "123",
        name: "Item sold",
        properties: %{price: 2.33},
        timestamp: "2022-09-24T08:25:57.589182Z"
      }

      {:ok, event: event}
    end

    test "sends request to client", %{client: client, event: event} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.track(client, event)

        assert_called_exactly(
          Client.send(client, %Rudder.Request{
            method: :post,
            params: %{
              anonymousId: "",
              context: %{library: %{name: "Rudder"}},
              event: "Item sold",
              integrations: %{},
              properties: %{price: 2.33},
              timestamp: "2022-09-24T08:25:57.589182Z",
              userId: "123"
            },
            uri: "v1/track"
          }),
          1
        )
      end
    end
  end
end
