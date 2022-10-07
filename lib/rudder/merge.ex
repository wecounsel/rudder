defmodule Rudder.Merge do
  @moduledoc """
  Merge struct for making `merge` calls
  """

  defstruct user_id: "",
            anonymous_id: "",
            merge_properties: []

  @type t :: %__MODULE__{
          user_id: String.t(),
          anonymous_id: String.t(),
          merge_properties: List.t()
        }

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
