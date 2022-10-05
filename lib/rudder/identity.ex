defmodule Rudder.Identity do
  @moduledoc """
  Identity
  """

  alias Rudder.Request

  # type is needed for batch support.
  defstruct type: "identify",
            user_id: "",
            anonymous_id: "",
            context: %{library: %{name: "Rudder"}},
            integrations: %{},
            timestamp: nil,
            traits: %{}

  def build_params(params) do
    %{
      type: __MODULE__.__struct__().type,
      userId: params.user_id,
      anonymousId: params.anonymous_id,
      context: params.context |> Request.add_library(),
      integrations: params.integrations,
      timestamp: params.timestamp || Request.default_timestamp(),
      traits: params.traits
    }
  end
end
