defmodule Rudder.Alias do
  @moduledoc """
  Alias struct for making `alias` calls
  """

  alias Rudder.{Alias, Request}

  # type is needed for batch support.
  defstruct type: "alias",
            user_id: "",
            previous_id: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{},
            traits: %{}

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        type: Alias.__struct__().type,
        userId: struct.user_id,
        previousId: struct.previous_id,
        context: struct.context |> Request.add_library(),
        integrations: struct.integrations,
        timestamp: struct.timestamp || Request.default_timestamp(),
        properties: struct.properties,
        traits: struct.traits
      }
    end
  end
end
