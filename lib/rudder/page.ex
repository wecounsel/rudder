defmodule Rudder.Page do
  @moduledoc """
  Page 
  """
  defstruct user_id: "",
            anonymous_id: "",
            name: "",
            context: %{},
            integrations: %{},
            timestamp: nil,
            properties: %{}
end
