defmodule Rudder.Page do
  @moduledoc """
  Page struct for making `page` calls
  """

  alias Rudder.{Page, Request}

  # type is needed for batch support.
  defstruct type: "page",
            user_id: "",
            anonymous_id: "",
            name: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{}

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        type: Page.__struct__().type,
        userId: struct.user_id,
        anonymousId: struct.anonymous_id,
        name: struct.name,
        context: struct.context |> Request.add_library(),
        integrations: struct.integrations,
        timestamp: struct.timestamp || Request.default_timestamp(),
        properties: struct.properties
      }
    end
  end
end
