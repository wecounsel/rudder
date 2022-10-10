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

  @type t :: %__MODULE__{
          type: String.t(),
          user_id: String.t(),
          anonymous_id: String.t(),
          name: String.t(),
          context: Map.t(),
          integrations: Map.t(),
          timestamp: String.t() | nil,
          properties: Map.t()
        }

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
