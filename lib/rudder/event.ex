defmodule Rudder.Event do
  @moduledoc """
  Event struct for making `track` calls
  """

  alias Rudder.Request

  # type is needed for batch support.
  defstruct type: "track",
            user_id: "",
            anonymous_id: "",
            name: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{}

  def build_params(params) do
    %{
      type: __MODULE__.__struct__().type,
      userId: params.user_id,
      anonymousId: params.anonymous_id,
      event: params.name,
      context: params.context |> Request.add_library(),
      integrations: params.integrations,
      timestamp: params.timestamp || Request.default_timestamp(),
      properties: params.properties
    }
  end
end
