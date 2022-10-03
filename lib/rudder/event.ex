defmodule Rudder.Event do
  @moduledoc """
  Event 
  """
  defstruct user_id: "",
            anonymous_id: "",
            name: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{}
end
