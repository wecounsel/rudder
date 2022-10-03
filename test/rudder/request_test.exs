defmodule Rudder.RequestTest do
  use ExUnit.Case
  doctest Rudder

  alias RudderClient
  alias Rudder.{Client, Identity, Request, Event, Result}

  describe ".check_user_id!" do
    test "raises an exeception if not provided a user_id or anonymous_id" do
      identity = %Identity{}

      assert_raise ArgumentError, "You must supply either a user_id or an anonymous_id", fn ->
        Request.check_user_id!(identity)
      end
    end

    test "does not raises an exeception if user_id is provided" do
      Request.check_user_id!(%Identity{user_id: "123"})
    end

    test "does not raises an exeception if anonymous_id is provided" do
      Request.check_user_id!(%Identity{anonymous_id: "123"})
    end
  end
end
