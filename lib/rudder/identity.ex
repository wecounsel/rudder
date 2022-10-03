defmodule Rudder.Identity do
  @moduledoc """
  Identity
  """

  defstruct user_id: "",
            anonymous_id: "",
            context: %{library: %{name: "Rudder"}},
            integrations: %{},
            timestamp: nil,
            traits: %{}
end
