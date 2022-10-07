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
    Sendable,
    Result
  }

  @type response() :: {:ok | :error, Result.t()}

  @doc """
  Sends an identity request to the RudderStack data plane
  """
  @spec identify(Client.t(), Identity.t()) :: response()
  def identify(client, %Identity{} = identity) do
    Request.check_user_id!(identity)

    request = %Request{
      uri: "v1/identify",
      params: Sendable.map_parameters(identity)
    }

    Client.send(client, request)
  end

  @doc """
  Sends an event request to the RudderStack data plane
  """
  @spec track(Client.t(), Event.t()) :: response()
  def track(client, %Event{} = event) do
    Request.check_user_id!(event)

    request = %Request{
      uri: "v1/track",
      params: Sendable.map_parameters(event)
    }

    Client.send(client, request)
  end

  @doc """
  Sends a page request to the RudderStack data plane
  """
  @spec page(Client.t(), Page.t()) :: response()
  def page(client, %Page{} = page) do
    Request.check_user_id!(page)

    request = %Request{
      uri: "v1/page",
      params: Sendable.map_parameters(page)
    }

    Client.send(client, request)
  end

  @doc """
  Sends an alias request to the RudderStack data plane
  """
  @spec alias(Client.t(), Alias.t()) :: response()
  def alias(client, %Alias{} = user_alias) do
    Request.check_user_id!(user_alias)

    request = %Request{
      uri: "v1/alias",
      params: Sendable.map_parameters(user_alias)
    }

    Client.send(client, request)
  end

  @doc """
  Sends a screen request to the RudderStack data plane
  """
  @spec screen(Client.t(), Screen.t()) :: response()
  def screen(client, %Screen{} = screen) do
    Request.check_user_id!(screen)

    request = %Request{
      uri: "v1/screen",
      params: Sendable.map_parameters(screen)
    }

    Client.send(client, request)
  end

  @doc """
  Sends a group request to the RudderStack data plane
  """
  @spec group(Client.t(), Group.t()) :: response()
  def group(client, %Group{} = group) do
    Request.check_user_id!(group)

    request = %Request{
      uri: "v1/group",
      params: Sendable.map_parameters(group)
    }

    Client.send(client, request)
  end

  @doc """
  Sends a merge request to the RudderStack data plane
  """
  @spec merge(Client.t(), Merge.t()) :: response()
  def merge(client, %Merge{} = merge) do
    Request.check_user_id!(merge)

    request = %Request{
      uri: "v1/merge",
      params: Sendable.map_parameters(merge)
    }

    Client.send(client, request)
  end

  @doc """
  Sends a batch request to the RudderStack data plane
  """
  @spec batch(Client.t(), Batch.t()) :: response()
  def batch(client, %Batch{} = batch) do
    validate_batch_items!(batch.items)

    request = %Request{
      uri: "v1/batch",
      params: Sendable.map_parameters(batch)
    }

    Client.send(client, request)
  end

  @doc """
  Check if a given string is nil, empty, or only whitespace
  """
  @spec blank?(String.t()) :: boolean()
  def blank?(nil), do: true
  def blank?(str), do: String.trim(str) == ""

  defp validate_batch_items!(items) do
    :ok =
      items
      |> Enum.each(fn item ->
        Request.check_user_id!(item)
        Request.check_batch_type!(item)
      end)
  end
end
