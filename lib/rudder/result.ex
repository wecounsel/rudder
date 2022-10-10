defmodule Rudder.Result do
  @moduledoc """
  Result
  """
  defstruct success: false

  @type t :: %__MODULE__{success: boolean()}
end
