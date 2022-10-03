defmodule Rudder.Request do
  @moduledoc """
  Defines the API request to be made and helper functions
  """
  defstruct uri: "", params: "", method: :post

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
end
