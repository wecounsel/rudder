defmodule Rudder.Group do
  @moduledoc """
  Group
  """

  defstruct user_id: "",
            anonymous_id: "",
            context: %{},
            integrations: %{},
            group_id: "",
            traits: %{},
            timestamp: nil
end
