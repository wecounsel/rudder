defmodule Rudder.ClientTest do
  use ExUnit.Case
  doctest Rudder.Client
  alias Rudder.{Client, Result}

  import Mock

  setup %{} do
    {:ok, data_plane_url: "https://api.example.com", write_key: "123"}
  end

  describe "new/1" do
    test "it creates a client struct", %{write_key: write_key, data_plane_url: data_plane_url} do
      assert Client.new(write_key: write_key, data_plane_url: data_plane_url) == %Client{
               write_key: write_key,
               data_plane_url: data_plane_url
             }
    end

    test "it throws an exception if the write_key is not provided", %{
      data_plane_url: data_plane_url
    } do
      assert_raise ArgumentError,
                   "write_key is required",
                   fn -> Client.new(data_plane_url: data_plane_url) end
    end

    test "it throws an exception if the data_plane_url is not provided", %{
      write_key: write_key
    } do
      assert_raise ArgumentError,
                   "data_plane_url is required",
                   fn -> Client.new(write_key: write_key) end
    end
  end

  describe "send/2" do
    setup _ do
      request = %Rudder.Request{
        method: :post,
        params: %{
          anonymousId: "",
          context: %{library: %{name: "Rudder"}},
          event: "Item sold",
          integrations: %{},
          properties: %{price: 2.33},
          timestamp: "2022-09-24T08:25:57.589182Z",
          userId: "123"
        },
        uri: "v1/track"
      }

      client = %Client{write_key: "123", data_plane_url: "https://api.example.com"}
      {:ok, client: client, request: request}
    end

    test "calls HTTPoison with a successful response and returns successful result", %{
      client: client,
      request: request
    } do
      with_mock HTTPoison,
        post: fn _url, _body, _options ->
          {:ok, %HTTPoison.Response{status_code: 200, body: ""}}
        end do
        assert Client.send(client, request) == {:ok, %Result{success: true}}

        assert_called_exactly(
          HTTPoison.post("https://api.example.com/v1/track", Jason.encode(request.params), [
            {"Content-Type", "application/json"},
            {:hackney, [basic_auth: {client.write_key, ""}]}
          ]),
          1
        )
      end
    end

    test "calls HTTPoison with a error response and returns unsuccessful result", %{
      client: client,
      request: request
    } do
      with_mock HTTPoison,
        post: fn _url, _body, _options ->
          {:error, %HTTPoison.Error{reason: "Bad request"}}
        end do
        assert Client.send(client, request) == {:error, %Result{success: false}}

        assert_called_exactly(
          HTTPoison.post(:_, :_, :_),
          1
        )
      end
    end

    test "calls HTTPoison with a bad response and returns unsuccessful result", %{
      client: client,
      request: request
    } do
      with_mock HTTPoison,
        post: fn _url, _body, _options ->
          {:ok, %HTTPoison.Response{status_code: 400}}
        end do
        assert Client.send(client, request) == {:error, %Result{success: false}}

        assert_called_exactly(
          HTTPoison.post(:_, :_, :_),
          1
        )
      end
    end
  end
end
