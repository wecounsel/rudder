defmodule Rudder.Group do
  @moduledoc """
  Group struct for making `group` calls
  """

  alias Rudder.{Group, Request}

  # type is needed for batch support.
  defstruct type: "group",
            user_id: "",
            anonymous_id: "",
            context: %{},
            integrations: %{},
            group_id: "",
            traits: %{},
            timestamp: nil

  @type t :: %__MODULE__{
          type: String.t(),
          user_id: String.t(),
          anonymous_id: String.t(),
          context: map(),
          integrations: map(),
          group_id: String.t(),
          traits: map(),
          timestamp: String.t() | nil
        }

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        type: Group.__struct__().type,
        userId: struct.user_id,
        anonymousId: struct.anonymous_id,
        context: struct.context |> Request.add_library(),
        integrations: struct.integrations,
        groupId: struct.group_id,
        traits: struct.traits,
        timestamp: struct.timestamp || Request.default_timestamp()
      }
    end
  end
end
