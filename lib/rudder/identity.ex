defmodule Rudder.Identity do
  @moduledoc """
  Identity struct for making `identify` calls
  """

  alias Rudder.{Identity, Request}

  # type is needed for batch support.
  defstruct type: "identify",
            user_id: "",
            anonymous_id: "",
            context: %{library: %{name: "Rudder"}},
            integrations: %{},
            timestamp: nil,
            traits: %{}

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        type: Identity.__struct__().type,
        userId: struct.user_id,
        anonymousId: struct.anonymous_id,
        context: struct.context |> Request.add_library(),
        integrations: struct.integrations,
        timestamp: struct.timestamp || Request.default_timestamp(),
        traits: struct.traits
      }
    end
  end
end
