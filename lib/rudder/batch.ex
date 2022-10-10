defmodule Rudder.Batch do
  @moduledoc """
  Batch struct for making `batch` calls
  """

  defstruct items: []

  @type t :: %__MODULE__{items: list()}

  defimpl Rudder.Sendable do
    def map_parameters(struct) do
      %{
        batch: struct.items |> Enum.map(&Rudder.Sendable.map_parameters/1)
      }
    end
  end
end
