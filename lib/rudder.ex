defmodule Rudder do
  @moduledoc """
  Documentation for `Rudder`.
  """
  alias Rudder.{Request, Client}

  @doc """
  Sends an identity request to the RudderStack data plane
  """
  def identify(conn, identity) do
    Request.check_user_id!(identity)

    request = %Request{
      uri: "v1/identify",
      params: %{
        userId: identity.user_id,
        anonymousId: identity.anonymous_id,
        context: identity.context |> Request.add_library(),
        integrations: identity.integrations,
        timestamp: identity.timestamp || Request.default_timestamp(),
        traits: identity.traits
      }
    }

    Client.send(conn, request)
  end

  @doc """
  Sends an event request to the RudderStack data plane
  """
  def track(conn, event) do
    Request.check_user_id!(event)

    request = %Request{
      uri: "v1/track",
      params: %{
        userId: event.user_id,
        anonymousId: event.anonymous_id,
        event: event.name,
        properties: event.properties,
        integrations: event.integrations,
        timestamp: event.timestamp || Request.default_timestamp(),
        context: event.context |> Request.add_library()
      }
    }

    Client.send(conn, request)
  end

  def page(conn, page) do
    Request.check_user_id!(page)

    request = %Request{
      uri: "v1/page",
      params: %{
        userId: page.user_id,
        anonymousId: page.anonymous_id,
        context: page.context |> Request.add_library(),
        integrations: page.integrations,
        name: page.name,
        properties: page.properties,
        timestamp: page.timestamp || Request.default_timestamp()
      }
    }

    Client.send(conn, request)
  end

  def alias(conn, user_alias) do
    Request.check_user_id!(user_alias)

    request = %Request{
      uri: "v1/alias",
      params: %{
        userId: user_alias.user_id,
        previousId: user_alias.previous_id,
        context: user_alias.context |> Request.add_library(),
        integrations: user_alias.integrations,
        properties: user_alias.properties,
        traits: user_alias.traits,
        timestamp: user_alias.timestamp || Request.default_timestamp()
      }
    }

    Client.send(conn, request)
  end

  def screen(conn, screen) do
    Request.check_user_id!(screen)

    request = %Request{
      uri: "v1/screen",
      params: %{
        userId: screen.user_id,
        anonymousId: screen.anonymous_id,
        context: screen.context |> Request.add_library(),
        integrations: screen.integrations,
        name: screen.name,
        properties: screen.properties,
        timestamp: screen.timestamp || Request.default_timestamp()
      }
    }

    Client.send(conn, request)
  end

  def blank?(str) do
    case str do
      nil -> true
      "" -> true
      " " <> r -> blank?(r)
      _ -> false
    end
  end
end
