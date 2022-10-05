defmodule Rudder.Merge do
  @moduledoc """
  Merge struct for making `merge` calls
  """

  defstruct user_id: "",
            anonymous_id: "",
            merge_properties: []

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        userId: struct.user_id,
        anonymousId: struct.anonymous_id,
        mergeProperties: struct.merge_properties
      }
    end
  end
end
