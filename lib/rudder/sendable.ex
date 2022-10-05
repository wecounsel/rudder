defprotocol Rudder.Sendable do
  @moduledoc """
  Protocol for structs that are sendable to RudderStack.
  """

  @doc """
  Maps a struct to parameters compatible with RudderStack's API
  """
  def map_parameters(struct)
end
