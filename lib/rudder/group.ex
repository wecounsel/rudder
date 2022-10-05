defmodule Rudder.Group do
  @moduledoc """
  Group struct for making `group` calls
  """

  alias Rudder.Request

  # type is needed for batch support.
  defstruct type: "group",
            user_id: "",
            anonymous_id: "",
            context: %{},
            integrations: %{},
            group_id: "",
            traits: %{},
            timestamp: nil

  def build_params(params) do
    %{
      type: __MODULE__.__struct__().type,
      userId: params.user_id,
      anonymousId: params.anonymous_id,
      context: params.context |> Request.add_library(),
      integrations: params.integrations,
      groupId: params.group_id,
      traits: params.traits,
      timestamp: params.timestamp || Request.default_timestamp()
    }
  end
end
