defmodule Rudder.Screen do
  @moduledoc """
  Screen
  """

  defstruct user_id: "",
            anonymous_id: "",
            name: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{}
end
