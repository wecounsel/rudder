defmodule Rudder.Request do
  @moduledoc """
  Defines the API request to be made and helper functions
  """
  defstruct uri: "", params: "", method: :post

  @type t :: %__MODULE__{
          uri: String.t(),
          params: String.t(),
          method: atom()
        }

  def add_library(context) when is_map(context) do
    Map.put(context, :library, %{name: "Rudder"})
  end

  def default_timestamp() do
    DateTime.utc_now() |> DateTime.to_iso8601()
  end

  def check_user_id!(resource) do
    if Rudder.blank?(resource.user_id) && Rudder.blank?(resource.anonymous_id) do
      raise ArgumentError, message: "You must supply either a user_id or an anonymous_id"
    end
  end

  def check_batch_type!(batch_item) do
    if Rudder.blank?(batch_item.type) do
      raise ArgumentError, message: "Batch items must specify a type"
    end

    unless valid_batch_item_type?(batch_item) do
      raise ArgumentError, message: "Batch item type not supported: #{inspect(batch_item.type)}"
    end
  end

  @valid_batch_types ["identify", "track", "page", "group", "screen"]

  defp valid_batch_item_type?(batch_item) when batch_item.type in @valid_batch_types, do: true
  defp valid_batch_item_type?(_), do: false
end
