defmodule Rudder.Event do
  @moduledoc """
  Event struct for making `track` calls
  """

  alias Rudder.{Event, Request}

  # type is needed for batch support.
  defstruct type: "track",
            user_id: "",
            anonymous_id: "",
            name: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{}

  @type t :: %__MODULE__{
          type: String.t(),
          user_id: String.t(),
          anonymous_id: String.t(),
          name: String.t(),
          context: map(),
          integrations: map(),
          timestamp: String.t() | nil,
          properties: map()
        }

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        type: Event.__struct__().type,
        userId: struct.user_id,
        anonymousId: struct.anonymous_id,
        event: struct.name,
        context: struct.context |> Request.add_library(),
        integrations: struct.integrations,
        timestamp: struct.timestamp || Request.default_timestamp(),
        properties: struct.properties
      }
    end
  end
end
