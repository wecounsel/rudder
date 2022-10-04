defmodule Rudder.Alias do
  @moduledoc """
  Alias
  """
  defstruct user_id: "",
            previous_id: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{},
            traits: %{}
end
