defmodule Rudder.Alias do
  @moduledoc """
  Alias
  """

  alias Rudder.Request

  # type is needed for batch support.
  defstruct type: "alias",
            user_id: "",
            previous_id: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{},
            traits: %{}

  def build_params(params) do
    %{
      type: __MODULE__.__struct__().type,
      userId: params.user_id,
      previousId: params.previous_id,
      context: params.context |> Request.add_library(),
      integrations: params.integrations,
      timestamp: params.timestamp || Request.default_timestamp(),
      properties: params.properties,
      traits: params.traits
    }
  end
end
