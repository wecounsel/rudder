defmodule Rudder do
  @moduledoc """
  Documentation for `Rudder`.
  """
  alias Rudder.{
    Request,
    Client,
    Identity,
    Event,
    Page,
    Group,
    Alias,
    Screen,
    Merge,
    Batch,
    Sendable
  }

  @doc """
  Sends an identity request to the RudderStack data plane
  """
  def identify(conn, %Identity{} = identity) do
    Request.check_user_id!(identity)

    request = %Request{
      uri: "v1/identify",
      params: Sendable.map_parameters(identity)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends an event request to the RudderStack data plane
  """
  def track(conn, %Event{} = event) do
    Request.check_user_id!(event)

    request = %Request{
      uri: "v1/track",
      params: Sendable.map_parameters(event)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a page request to the RudderStack data plane
  """
  def page(conn, %Page{} = page) do
    Request.check_user_id!(page)

    request = %Request{
      uri: "v1/page",
      params: Sendable.map_parameters(page)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends an alias request to the RudderStack data plane
  """
  def alias(conn, %Alias{} = user_alias) do
    Request.check_user_id!(user_alias)

    request = %Request{
      uri: "v1/alias",
      params: Sendable.map_parameters(user_alias)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a screen request to the RudderStack data plane
  """
  def screen(conn, %Screen{} = screen) do
    Request.check_user_id!(screen)

    request = %Request{
      uri: "v1/screen",
      params: Sendable.map_parameters(screen)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a group request to the RudderStack data plane
  """
  def group(conn, %Group{} = group) do
    Request.check_user_id!(group)

    request = %Request{
      uri: "v1/group",
      params: Sendable.map_parameters(group)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a merge request to the RudderStack data plane
  """
  def merge(conn, %Merge{} = merge) do
    Request.check_user_id!(merge)

    request = %Request{
      uri: "v1/merge",
      params: Sendable.map_parameters(merge)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a batch request to the RudderStack data plane
  """
  def batch(conn, %Batch{} = batch) do
    validate_batch_items!(batch.items)

    request = %Request{
      uri: "v1/batch",
      params: Sendable.map_parameters(batch)
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

  defp validate_batch_items!(items) do
    :ok =
      items
      |> Enum.each(fn item ->
        Request.check_user_id!(item)
        Request.check_batch_type!(item)
      end)
  end
end
