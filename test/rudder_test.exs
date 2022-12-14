defmodule RudderTest do
  use ExUnit.Case
  doctest Rudder
  import Mock

  alias RudderClient

  alias Rudder.{
    Client,
    Identity,
    Request,
    Event,
    Result,
    Page,
    Alias,
    Screen,
    Group,
    Merge,
    Batch
  }

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
          Client.send(client, %Request{
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
          Client.send(client, %Request{
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

  describe "page/2" do
    setup(_) do
      page = %Page{
        user_id: "123",
        name: "Page View",
        properties: %{title: "Home", path: "/"},
        timestamp: "2022-09-24T08:25:57.589182Z"
      }

      {:ok, page: page}
    end

    test "sends request to client", %{client: client, page: page} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.page(client, page)

        assert_called_exactly(
          Client.send(client, %Request{
            method: :post,
            params: %{
              anonymousId: "",
              context: %{library: %{name: "Rudder"}},
              name: "Page View",
              integrations: %{},
              properties: %{title: "Home", path: "/"},
              timestamp: "2022-09-24T08:25:57.589182Z",
              userId: "123"
            },
            uri: "v1/page"
          }),
          1
        )
      end
    end
  end

  describe "alias/2" do
    setup(_) do
      user_alias = %Alias{
        user_id: "123",
        previous_id: "456",
        properties: %{some: "value"},
        timestamp: "2022-09-24T08:25:57.589182Z"
      }

      {:ok, user_alias: user_alias}
    end

    test "sends request to client", %{client: client, user_alias: user_alias} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.alias(client, user_alias)

        assert_called_exactly(
          Client.send(client, %Request{
            method: :post,
            params: %{
              context: %{library: %{name: "Rudder"}},
              integrations: %{},
              previousId: "456",
              userId: "123",
              traits: %{},
              timestamp: "2022-09-24T08:25:57.589182Z"
            },
            uri: "v1/alias"
          }),
          1
        )
      end
    end
  end

  describe "screen/2" do
    setup(_) do
      screen = %Screen{
        user_id: "123",
        name: "Screen View",
        properties: %{},
        timestamp: "2022-09-24T08:25:57.589182Z"
      }

      {:ok, screen: screen}
    end

    test "sends request to client", %{client: client, screen: screen} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.screen(client, screen)

        assert_called_exactly(
          Client.send(client, %Request{
            method: :post,
            params: %{
              anonymousId: "",
              context: %{library: %{name: "Rudder"}},
              name: "Screen View",
              integrations: %{},
              properties: %{},
              timestamp: "2022-09-24T08:25:57.589182Z",
              userId: "123"
            },
            uri: "v1/screen"
          }),
          1
        )
      end
    end
  end

  describe "group/2" do
    setup(_) do
      group = %Group{
        user_id: "123",
        group_id: "group1",
        traits: %{name: "Company", industry: "Industry", employees: 123},
        timestamp: "2022-09-24T08:25:57.589182Z"
      }

      {:ok, group: group}
    end

    test "sends request to client", %{client: client, group: group} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.group(client, group)

        assert_called_exactly(
          Client.send(client, %Request{
            method: :post,
            params: %{
              anonymousId: "",
              context: %{library: %{name: "Rudder"}},
              groupId: "group1",
              integrations: %{},
              traits: %{name: "Company", industry: "Industry", employees: 123},
              timestamp: "2022-09-24T08:25:57.589182Z",
              userId: "123"
            },
            uri: "v1/group"
          }),
          1
        )
      end
    end
  end

  describe "merge/2" do
    setup(_) do
      merge = %Merge{
        user_id: "123",
        merge_properties: [
          %{type: "email", value: "geralt@example.com"},
          %{type: "mobile", value: "+15555552263"}
        ]
      }

      {:ok, merge: merge}
    end

    test "sends request to client", %{client: client, merge: merge} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.merge(client, merge)

        assert_called_exactly(
          Client.send(client, %Request{
            method: :post,
            params: %{
              anonymousId: "",
              userId: "123",
              mergeProperties: [
                %{type: "email", value: "geralt@example.com"},
                %{type: "mobile", value: "+15555552263"}
              ]
            },
            uri: "v1/merge"
          }),
          1
        )
      end
    end
  end

  describe "batch/2" do
    setup(_) do
      batch = %Batch{
        items: [
          %Identity{
            user_id: "123",
            timestamp: "2022-09-24T08:25:57.589182Z"
          },
          %Event{
            user_id: "123",
            name: "Item sold",
            properties: %{price: 2.33},
            timestamp: "2022-09-24T08:25:57.589182Z"
          },
          %Page{
            user_id: "123",
            name: "Page View",
            properties: %{title: "Home", path: "/"},
            timestamp: "2022-09-24T08:25:57.589182Z"
          }
        ]
      }

      {:ok, batch: batch}
    end

    test "sends request to client", %{client: client, batch: batch} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        Rudder.batch(client, batch)

        assert_called_exactly(
          Client.send(client, %Request{
            method: :post,
            params: %{
              batch: [
                %{
                  type: "identify",
                  userId: "123",
                  anonymousId: "",
                  context: %{library: %{name: "Rudder"}},
                  integrations: %{},
                  timestamp: "2022-09-24T08:25:57.589182Z",
                  traits: %{}
                },
                %{
                  type: "track",
                  anonymousId: "",
                  context: %{library: %{name: "Rudder"}},
                  event: "Item sold",
                  integrations: %{},
                  properties: %{price: 2.33},
                  timestamp: "2022-09-24T08:25:57.589182Z",
                  userId: "123"
                },
                %{
                  type: "page",
                  anonymousId: "",
                  context: %{library: %{name: "Rudder"}},
                  name: "Page View",
                  integrations: %{},
                  properties: %{title: "Home", path: "/"},
                  timestamp: "2022-09-24T08:25:57.589182Z",
                  userId: "123"
                }
              ]
            },
            uri: "v1/batch"
          }),
          1
        )
      end
    end
  end

  describe "batch/2 with invalid type" do
    setup(_) do
      batch = %Batch{
        items: [
          # Alias is not a valid type for batch
          %Alias{
            user_id: "123",
            previous_id: "456",
            properties: %{some: "value"},
            timestamp: "2022-09-24T08:25:57.589182Z"
          }
        ]
      }

      {:ok, batch: batch}
    end

    test "raises an error", %{client: client, batch: batch} do
      with_mock Client, send: fn _client, _identity -> {:ok, nil} end do
        assert_raise ArgumentError,
                     "Batch item type not supported: \"alias\"",
                     fn -> Rudder.batch(client, batch) end

        assert_not_called(Client.send(:_))
      end
    end
  end
end
