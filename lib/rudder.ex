defmodule Rudder do
  @moduledoc """
  Documentation for `Rudder`.
  """
  alias Rudder.{Request, Client, Identity, Event, Page, Group, Alias, Screen, Merge, Batch}

  @doc """
  Sends an identity request to the RudderStack data plane
  """
  def identify(conn, identity) do
    Request.check_user_id!(identity)

    request = %Request{
      uri: "v1/identify",
      params: Rudder.Identity.build_params(identity)
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
      params: Rudder.Event.build_params(event)
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a page request to the RudderStack data plane
  """
  def page(conn, page) do
    Request.check_user_id!(page)

    request = %Request{
      uri: "v1/page",
      params: Rudder.Page.build_params(page)
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
      params: Rudder.Alias.build_params(user_alias)
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
      params: Rudder.Screen.build_params(screen)
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
      params: Rudder.Group.build_params(group)
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
      params: %{
        userId: merge.user_id,
        anonymousId: merge.anonymous_id,
        mergeProperties: merge.merge_properties
      }
    }

    Client.send(conn, request)
  end

  @doc """
  Sends a batch request to the RudderStack data plane
  """
  def batch(conn, %Batch{} = batch) do
    validate_batch_items!(batch.items)

    batch_items =
      batch.items
      |> Enum.map(&batch_item_params/1)

    request = %Request{
      uri: "v1/batch",
      params: %{
        batch: batch_items
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

  defp batch_item_params(%Identity{} = batch_item),
    do: Rudder.Identity.build_params(batch_item)

  defp batch_item_params(%Event{} = batch_item),
    do: Rudder.Event.build_params(batch_item)

  defp batch_item_params(%Page{} = batch_item),
    do: Rudder.Page.build_params(batch_item)

  defp batch_item_params(%Group{} = batch_item),
    do: Rudder.Event.build_params(batch_item)

  defp batch_item_params(%{type: type}),
    do: raise(ArgumentError, message: "Batch item type not suppported: #{inspect(type)}")

  defp validate_batch_items!(items) do
    :ok =
      items
      |> Enum.each(fn item ->
        Request.check_user_id!(item)
        Request.check_batch_type!(item)
      end)
  end
end
