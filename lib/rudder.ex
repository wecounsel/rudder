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

  def blank?(str) do
    case str do
      nil -> true
      "" -> true
      " " <> r -> blank?(r)
      _ -> false
    end
  end
end
