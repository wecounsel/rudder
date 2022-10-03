defmodule Rudder.Client do
  @moduledoc """
  Handles sending the API request
  """
  require Logger
  alias __MODULE__
  alias Rudder.Result

  defstruct write_key: "", data_plane_url: ""

  def new(data_plane_url: _data_plane_url) do
    raise ArgumentError, "write_key is required"
  end

  def new(write_key: _write_key) do
    raise ArgumentError, "data_plane_url is required"
  end

  def new(write_key: write_key, data_plane_url: data_plane_url) do
    if Rudder.blank?(write_key) do
      raise ArgumentError, "write_key is required"
    end

    if Rudder.blank?(data_plane_url) do
      raise ArgumentError, "data_plane_url is required"
    end

    %Client{write_key: write_key, data_plane_url: data_plane_url}
  end

  def send(client, request) do
    options = [
      {"Content-Type", "application/json"},
      hackney: [basic_auth: {client.write_key, ""}]
    ]

    json = Jason.encode(request.params)

    case HTTPoison.post(
           api_url(client.data_plane_url, request.uri),
           json,
           options
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.debug("#{inspect(body)}")
        {:ok, %Result{success: true}}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        Logger.debug("status_code: #{status_code}")
        {:error, %Result{success: false}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error(reason)
        {:error, %Result{success: false}}
    end
  end

  def api_url(base_url, uri) do
    Enum.join([base_url, uri], "/")
  end
end
